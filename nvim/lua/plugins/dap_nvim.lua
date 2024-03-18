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
  "rcarriga/nvim-dap-ui",
  lazy = true,
  keys = function()
    local toggle_bottom = function()
      require("dapui").toggle({ layout = 2, reset = true })
    end
    local toggle_left = function()
      require("dapui").toggle({ layout = 1, reset = true })
    end
    return {
      { "<M-j>", toggle_bottom, mode = "n", desc = "[dap-ui] toggle repl" },
      { "<M-h>", toggle_left, mode = "n", desc = "[dap-ui] toggle stacks" },
    }
  end,
  opts = {
    controls = {
      enabled = false,
    },
  },
  dependencies = {
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
          { "<M-c>", clear_breakpoints, mode = "n", desc = "[dap] clear breakpoints" },
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
  },
}
