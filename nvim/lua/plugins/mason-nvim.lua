local _, wf = pcall(require, "vim.lsp._watchfiles")
wf._watchfunc = function()
  return function() end
end

-- diagnostic
local diag_config = {
  virtual_text = true,
  signs = false,
  underline = false,
  update_in_insert = false,
  float = {
    header = "",
    prefix = "",
    focusable = true,
    title = " σ`∀´)σ ",
    border = _G.border,
    source = true,
  },
}

vim.diagnostic.config(diag_config)
vim.diagnostic.disable()

local diagnostics_active = false
local function toggle_diagnostics()
  if diagnostics_active then
    diagnostics_active = false
    vim.diagnostic.disable()
  else
    diagnostics_active = true
    vim.diagnostic.enable()
  end
end

vim.keymap.set("n", "<M-d>", toggle_diagnostics, { desc = "toggle diagnostic" })

-- float win
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = _G.border
  opts.max_width = _G.floatw
  opts.max_height = _G.floath
  opts.wrap = _G.floatwrap
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
local util = require("vim.lsp.util")

local function split_lines(value)
  value = string.gsub(value, "&nbsp;", " ")
  value = string.gsub(value, "&gt;", ">")
  value = string.gsub(value, "&lt;", "<")
  value = string.gsub(value, "\\", "")
  return vim.split(value, "\n", { plain = true, trimempty = true })
end

local function convert_input_to_markdown_lines(input, contents)
  contents = contents or {}
  assert(type(input) == "table", "Expected a table for LSP input")
  if input.kind then
    local value = input.value or ""
    vim.list_extend(contents, split_lines(value))
  end
  if (contents[1] == "" or contents[1] == nil) and #contents == 1 then
    return {}
  end
  return contents
end

local function hover(_, result, ctx, config)
  config = config or {}
  config.focus_id = ctx.method
  if vim.api.nvim_get_current_buf() ~= ctx.bufnr then
    -- Ignore result since buffer changed. This happens for slow language servers.
    return
  end
  if not (result and result.contents) then
    if config.silent ~= true then
      vim.notify("No information available")
    end
    return
  end
  local contents ---@type string[]
  contents = convert_input_to_markdown_lines(result.contents)
  if vim.tbl_isempty(contents) then
    if config.silent ~= true then
      vim.notify("No information available")
    end
    return
  end
  return util.open_floating_preview(contents, "markdown", config)
end

return {
  {
    "williamboman/mason.nvim",
    ft = { "json", "python", "sh", "lua", "c", "cpp", "cuda", "zig" },
    init = function()
      vim.api.nvim_create_user_command("M", "Mason", {})
    end,
    opts = {
      ui = { border = _G.border, width = 0.7, height = 0.5 },
    },
  },
  {
    -- Better installer than default
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = "williamboman/mason.nvim",
    opts = function()
      local ensure_installed = {
        -- lsp --
        "clangd",
        "pyright",
        "lua-language-server",
        "zls",
        -- formatter --
        "jq",
        "ruff",
        "shfmt",
        "stylua",
      }
      return {
        ensure_installed = ensure_installed,
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ft = { "zig", "c", "cpp", "cuda", "python", "lua" },
    cmd = { "LspInfo" },
    dependencies = {
      "williamboman/mason.nvim",
      -- Better installer than default
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    init = function()
      vim.api.nvim_create_user_command("LI", "LspInfo", {})

      -- customize hover when pressing K
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = _G.border,
        title = " |･ω･) ? ",
        zindex = 500,
        focusable = true,
        max_width = 120,
      })

      -- customize signature help when pressing gs
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = _G.border,
        title = " (・・ ) ? ",
        max_width = _G.floatw,
      })
    end,
    config = function(_, opts)
      require("lspconfig").zls.setup({})
      require("lspconfig").clangd.setup({})
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            runtime = { version = "Lua 5.1" },
            diagnostics = { globals = { "vim", "use" } },
            completion = { callSnippet = "Both" },
            workspace = { checkThirdParty = false },
            semantic = { enable = false },
            hint = { enable = true },
          },
        },
      })
      require("lspconfig").pyright.setup({
        handlers = {
          ["textDocument/publishDiagnostics"] = function() end,
          ["textDocument/hover"] = vim.lsp.with(hover, {
            border = _G.border,
            title = " |･ω･) ? ",
            max_width = 120,
            zindex = 500,
          }),
        },
        settings = {
          pyright = {
            disableOrganizeImports = false,
          },
          python = {
            analysis = {
              ignore = { "*" },
              logLevel = "Information",
              autoImportCompletions = true,
              autoSearchPaths = true,
              diagnosticMode = "off",
              typeCheckingMode = "off",
              useLibraryCodeForTypes = false,
            },
          },
        },
      })

      -- disable all format, use conform with mason
      require("lspconfig.util").default_config.format = {
        formatting_options = nil,
        timeout_ms = nil,
      }

      -- LspInfo width and height
      local info = require("lspconfig.ui.windows").percentage_range_window
      require("lspconfig.ui.windows").percentage_range_window = function(_, _)
        return info(0.7, 0.5)
      end

      -- LspInfo command border
      require("lspconfig.ui.windows").default_options.border = _G.border

      local lsp_highlight = false
      local toggle_lsp_highlight = function()
        if lsp_highlight then
          vim.lsp.buf.clear_references()
          lsp_highlight = false
        else
          vim.lsp.buf.document_highlight()
          lsp_highlight = true
        end
      end

      vim.keymap.set("n", "<space>i", toggle_lsp_highlight, { desc = "toggle lsp highlight" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "lsp references" })
      vim.keymap.set("n", "gn", vim.lsp.buf.rename, { desc = "lsp rename" })
      vim.keymap.set("n", "<space>q", vim.diagnostic.setqflist, { desc = "diagnostic qflist" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "lsp go to definition" })

      local inlay_hints_visible = false
      local function toggle_inlay_hints()
        if vim.g.inlay_hints_visible then
          inlay_hints_visible = false
        else
          inlay_hints_visible = true
        end
        vim.lsp.inlay_hint.enable(inlay_hints_visible)
      end

      vim.keymap.set("n", "<space>q", vim.diagnostic.setqflist)
      -- crr in Normal mode maps to vim.lsp.buf.code_action()
      -- <C-R>r and <C-R><C-R> in Visual mode map to vim.lsp.buf.code_action()
      -- crn in Normal mode maps to vim.lsp.buf.rename()
      -- gr in Normal mode maps to vim.lsp.buf.references()
      -- <C-S> in Insert mode maps to vim.lsp.buf.signature_help()
      -- [d and ]d map to vim.diagnostic.goto_prev() and vim.diagnostic.goto_next() (respectively)
      -- <C-W>d maps to vim.diagnostic.open_float()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = _G.group,
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
          if vim.lsp.get_client_by_id(ev.data.client_id).name ~= "pyright" then
            vim.keymap.set("n", "gh", toggle_inlay_hints, { desc = "toggle inlay hints" })
          end
        end,
      })
    end,
  },
}
