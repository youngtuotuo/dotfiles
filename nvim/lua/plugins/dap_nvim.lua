-- INFO: Currently work in WSL2
-- The REPL can be used to evaluate expressions. A `omnifunc` is set to
-- support completion of expressions. It supports the following special
-- commands:
--
--   .exit               Closes the REPL
--   .c or .continue     Same as |dap.continue|
--   .n or .next         Same as |dap.step_over|
--   .into               Same as |dap.step_into|
--   .into_target        Same as |dap.step_into{askForTargets=true}|
--   .out                Same as |dap.step_out|
--   .up                 Same as |dap.up|
--   .down               Same as |dap.down|
--   .goto               Same as |dap.goto_|
--   .scopes             Prints the variables in the current scopes
--   .threads            Prints all threads
--   .frames             Print the stack frames
--   .capabilities       Print the capabilities of the debug adapter
--   .b or .back         Same as |dap.step_back|
--   .rc or
--   .reverse-continue   Same as |dap.reverse_continue|

return {
  {
    "rcarriga/nvim-dap-ui",
    cmd = { "DB" },
    keys = function()
      local toggle = function()
        require("dapui").toggle()
      end
      return {
        { "<M-r>", toggle, mode = "n", desc = "[dap-ui] toggle ui" },
      }
    end,
    config = function()
      require("dapui").setup()
    end,
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      {
        "mfussenegger/nvim-dap",
        lazy = true,
        keys = function()
          -- stylua: ignore start
          local continue     = function() require("dap").continue() end
          local step_over    = function() require("dap").step_over() end
          local step_into    = function() require("dap").step_into() end
          local step_out     = function() require("dap").step_out() end
          local breakpoint   = function() require("dap").toggle_breakpoint() end
          local close        = function() require("dap").close() end
          local float_frames = function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.frames)
          end
          local float_scopes = function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.scopes)
          end

          return {
            { "<M-q>", close,        mode = "n", desc = "[dap] close dap" },
            { "<M-x>", continue,     mode = "n", desc = "[dap] continue execution till next breakpoint" },
            { "<M-n>", step_over,    mode = "n", desc = "[dap] forward one execution" },
            { "<M-i>", step_into,    mode = "n", desc = "[dap] step into a function or method" },
            { "<M-o>", step_out,     mode = "n", desc = "[dap] step out of a function or method" },
            { "<M-a>", breakpoint,   mode = "n", desc = "[dap] toggle breakpoint" },
            { "<M-f>", float_frames, mode = "n", desc = "[dap] inspect frames in float" },
            { "<M-s>", float_scopes, mode = "n", desc = "[dap] inspect scopes in float" },
          }
        end,
        config = function()
          local dap = require("dap")
          if vim.fn.has("win32") == 1 then -- cpptools
            dap.adapters.cppdbg = {
              id = "cppdbg",
              type = "executable",
              command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7.cmd",
              options = {
                detached = true,
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
          elseif vim.fn.has("mac") == 1 then -- codelldb
            dap.adapters.codelldb = {
              type = "server",
              port = "${port}",
              executable = {
                -- CHANGE THIS to your path!
                command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                args = { "--port", "${port}" },
              },
            }
            dap.configurations.c = {
              {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                  return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
              },
            }
          else -- gdb
            dap.adapters.gdb = {
              type = "executable",
              command = "gdb",
              args = { "-i", "dap" },
            }
            dap.configurations.c = {
              {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                  return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
              },
            }
          end
          dap.configurations.cpp = dap.configurations.c

          dap.adapters.python = {
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/debugpy-adapter",
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
                -- TODO: Handle mac python path
                local cwd = vim.fn.getcwd()
                if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                  return cwd .. "/venv/bin/python"
                elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                  return cwd .. "/.venv/bin/python"
                else
                  -- TODO: Maybe we can use $ which python3
                  if vim.fn.has("win32") == 1 then
                    return "C:/Users/User/AppData/Local/Microsoft/WindowsApps/python3.exe"
                  elseif vim.fn.has("mac") == 1 then
                    return "/Library/Frameworks/Python.framework/Versions/3.11/bin/python3"
                  end
                  return os.getenv("HOME") .. "/.local/bin/python3"
                end
              end,
            },
          }
        end,
      },
    },
  },
}
