return {
  {
    "rcarriga/nvim-dap-ui",
    ft = { "c", "python", "cpp" },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap",
    },
    keys = function()
      local dapui = require("dapui")
      local toggle_all = function()
        dapui.toggle({ reset = true })
      end
      local toggle_watches = function()
        dapui.toggle({ layout = 3, reset = true })
      end
      return {
        { "<M-s>", toggle_all, mode = "n", desc = "[dap-ui] toggle all ui" },
        { "<M-w>", toggle_watches, mode = "n", desc = "[dap-ui] toggle watches" },
        { "<M-f>", dapui.float_element, mode = "n", desc = "[dap-ui] float" },
      }
    end,
    opts = {
      controls = {
        enabled = false,
      },
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.25,
            },
            {
              id = "breakpoints",
              size = 0.25,
            },
            {
              id = "stacks",
              size = 0.25,
            },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            {
              id = "repl",
              size = 0.5,
            },
            {
              id = "console",
              size = 0.5,
            },
          },
          position = "bottom",
          size = 10,
        },
        {
          elements = {
            {
              id = "watches",
              size = 1,
            },
          },
          position = "bottom",
          size = 20,
        },
      },
    },
    config = function(_, opts)
      local dapui = require("dapui")
      dapui.setup(opts)
    end,
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    keys = function()
      local continue = function()
        require("dap").continue()
      end
      local step_over = function()
        require("dap").step_over()
      end
      local step_into = function()
        require("dap").step_into()
      end
      local step_out = function()
        require("dap").step_out()
      end
      local terminate = function()
        require("dap").terminate()
      end
      local add_breakpoint = function()
        require("dap").toggle_breakpoint()
      end
      local clear_breakpoints = function()
        require("dap").clear_breakpoints()
      end

      return {
        { "<M-q>", terminate, mode = "n", desc = "[dap] terminate dap" },
        { "<M-x>", continue, mode = "n", desc = "[dap] continue execution till next breakpoint" },
        { "<M-n>", step_over, mode = "n", desc = "[dap] forward one execution" },
        { "<M-i>", step_into, mode = "n", desc = "[dap] step into a function or method" },
        { "<M-o>", step_out, mode = "n", desc = "[dap] step out of a function or method" },
        { "<M-a>", add_breakpoint, mode = "n", desc = "[dap] toggle breakpoint" },
        { "<M-l>", clear_breakpoints, mode = "n", desc = "[dap] clear breakpoints" },
      }
    end,
    config = function()
      local dap = require("dap")
      local codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }
      if vim.fn.has("win32") == 1 then
        codelldb.executable.detached = false
        codelldb.executable.command = vim.fn.stdpath("data") .. "/mason/bin/codelldb.cmd"
      end
      dap.adapters.codelldb = codelldb
      dap.configurations.c = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. _G.sep, "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = function()
            local argument_string = vim.fn.input("Program arguments: ")
            return vim.fn.split(argument_string, " ", true)
          end,
        },
      }
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
          args = function()
            local argument_string = vim.fn.input("Program arguments: ")
            return vim.fn.split(argument_string, " ", true)
          end,
          -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
          module = string.gsub(vim.fn.expand("%:r"), "/", "."),
          python = function()
            if vim.fn.executable("python3") then
              return vim.fn.exepath("python3")
            elseif vim.fn.executable("python") then
              return vim.fn.exepath("python")
            else
              return dap.ABORT
            end
          end,
        },
      }
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.c", "*.py" },
        group = _G.auG,
        callback = function()
          dap.configurations.python[1].module = string.gsub(vim.fn.expand("%:r"), "/", ".")
        end,
        desc = "[dap] Change module when switch buffer",
      })
    end,
  },
}
