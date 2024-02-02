-- INFO: Currently work in WSL2
return {
  {
    "rcarriga/nvim-dap-ui",
    cmd = { "DB" },
    init = function()
      vim.api.nvim_create_user_command("DB", function()
        require("dapui").toggle()
      end, {})
      vim.api.nvim_create_user_command("DBC", function()
        require("dapui").close()
      end, {})
    end,
    dependencies = {
      {
        "mfussenegger/nvim-dap",
        lazy = true,
        keys = function()
          -- stylua: ignore start
          local continue = function() require("dap").continue() end
          local step_over = function() require("dap").step_over() end
          local step_into = function() require("dap").step_into() end
          local step_out = function() require("dap").step_out() end
          local breakpoint = function() require("dap").toggle_breakpoint() end
          local repl = function() require("dap").repl.open() end
          local float_frames = function() local widgets = require("dap.ui.widgets") widgets.centered_float(widgets.frames) end
          local float_scopes = function() local widgets = require("dap.ui.widgets") widgets.centered_float(widgets.scopes) end

          -- local ts_obj_status, ts_rep = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
          -- if ts_obj_status then
          --   next_hunk, prev_hunk = ts_rep.make_repeatable_move_pair(next_hunk, prev_hunk)
          -- end

          -- TODO: Think bettwe shortcuts here
          return {
            { mode = "n", "<leader><leader>c", continue },
            { mode = "n", "<leader><leader>s", step_over },
            { mode = "n", "<leader><leader>i", step_into },
            { mode = "n", "<leader><leader>o", step_out },
            { mode = "n", "<Leader><leader>b", breakpoint },
            { mode = "n", "<Leader><leader>r", repl },
            { mode = "n", "<Leader><leader>f", float_frames },
            { mode = "n", "<Leader><leader>S", float_scopes },
          }
        end,
        config = function()
          local dap = require("dap")
          dap.adapters.cppdbg = {
            id = "cppdbg",
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
            options = {
              detached = vim.fn.has("win32") and false or true,
            },
          }
          dap.configurations.c = {
            {
              name = "Launch file",
              type = "cppdbg",
              request = "launch",
              program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
              end,
              cwd = "${workspaceFolder}",
              stopAtEntry = true,
            },
          }
          dap.configurations.cpp = dap.configurations.c

          dap.adapters.python = {
            type = "executable",
            command = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/debugpy/debugpy-adapter",
            args = {},
            options = {
              source_filetype = "python",
            },
          }
          dap.configurations.python = {
            {
              -- The first three options are required by nvim-dap
              type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
              request = "launch",
              name = "Launch file",

              -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

              program = "${file}", -- This configuration will launch the current file if used.
              pythonPath = function()
                -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                local cwd = vim.fn.getcwd()
                if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                  return cwd .. "/venv/bin/python"
                elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                  return cwd .. "/.venv/bin/python"
                else
                  return os.getenv("HOME") .. "/.local/bin/python3"
                end
              end,
            },
          }
        end,
      },
    },
    config = function()
      require("dapui").setup()
    end,
  },
}
