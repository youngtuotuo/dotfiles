" highlight NormalFloat guifg=NONE guibg=#1b212d
" highlight FloatBorder guifg=NONE guibg=#1b212d

lua << EOF
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warn = "#e0af68",
  Info = "#0db9d7",
  Hint = "#10B981"
})
--vim.api.nvim_command [[autocmd CursorHold  * lua vim.lsp.buf.document_highlight()]]
vim.api.nvim_command [[autocmd CursorMoved * lua vim.lsp.buf.clear_references()]]
local protocol = require'vim.lsp.protocol'
protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local custom_on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=false }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>i', '<cmd>lua vim.lsp.buf.document_highlight()<CR>', opts)
  --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float(0, {show_header=false, scope="line", source="if_many"})<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Code actions
capabilities.textDocument.codeAction = {
  dynamicRegistration = false;
      codeActionLiteralSupport = {
          codeActionKind = {
              valueSet = {
                 "",
                 "quickfix",
                 "refactor",
                 "refactor.extract",
                 "refactor.inline",
                 "refactor.rewrite",
                 "source",
                 "source.organizeImports",
              };
          };
      };
}

-- Snippets
capabilities.textDocument.completion.completionItem.snippetSupport = true;

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local nvim_lsp = require('lspconfig')
local servers = { 'pyright', 'vimls', 'bashls', 'yamlls' }
local border = {
    { "╭", "NormalFloat" },
    { "─", "NormalFloat" },
    { "╮", "NormalFloat" },
    { "│", "NormalFloat" },
    { "╯", "NormalFloat" },
    { "─", "NormalFloat" },
    { "╰", "NormalFloat" },
    { "│", "NormalFloat" },
}
local handlers = {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {relative='cursor', style='minimal', border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border}),
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
-- 'cmake', 'diagnosticls', 'dockerls'
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    handlers = handlers,
    on_attach = custom_on_attach,
    init_options = {
        onlyAnalyzeProjectsWithOpenFiles = false,
        suggestFromUnimportedLibraries = false,
        closingLabels = true,
    };
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- Send diagnostics to quickfix list
do
  local method = "textDocument/publishDiagnostics"
  local default_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, method, result, client_id, bufnr, config)
    default_handler(err, method, result, client_id, bufnr, config)
    local diagnostics = vim.lsp.diagnostic.get_all()
    local qflist = {}
    for bufnr, diagnostic in pairs(diagnostics) do
      for _, d in ipairs(diagnostic) do
        d.bufnr = bufnr
        d.lnum = d.range.start.line + 1
        d.col = d.range.start.character + 1
        d.text = d.message
        table.insert(qflist, d)
      end
    end
  vim.lsp.util.set_qflist(qflist)
  end
end
-- diagnostic after each line
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    -- virtual_text = false,
    signs = false,
    update_in_insert=false,
    virtual_text = {
      source = "if_many",
      format=function(diagnostic)
          if diagnostic.severity == vim.diagnostic.severity.ERROR then
              return " "
          end
          if diagnostic.severity == vim.diagnostic.severity.WARN then
              return " "
          end
          if diagnostic.severity == vim.diagnostic.severity.HINT then
              return " "
          end
          if diagnostic.severity == vim.diagnostic.severity.INFO then
              return " "
          end
          return diagnostic.message
      end,
      prefix='',
      spacing=0,
    }
    --float = {
    --  source = "always"
    --},
  }
)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
--local signs = { Error = "", Warn = "", Hint = "", Info = "" }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, linehl = "", numhl = "" })
end

-- symbols-outline.nvim
--vim.g.symbols_outline = {
--    highlight_hovered_item = true,
--    show_guides = false,
--    auto_preview = false,
--    position = 'right',
--    width = 25,
--    show_numbers = false,
--    show_relative_numbers = false,
--    show_symbol_details = false,
--    preview_bg_highlight = 'Pmenu',
--    keymaps = { -- These keymaps can be a string or a table for multiple keys
--        close = {"<Esc>", "q"},
--        goto_location = "<Cr>",
--        focus_location = "o",
--        hover_symbol = "<C-space>",
--        toggle_preview = "K",
--        rename_symbol = "r",
--        code_actions = "a",
--    },
--    lsp_blacklist = {},
--    symbol_blacklist = {},
--    symbols = {
--        File = {icon = "", hl = "TSURI"},
--        Module = {icon = "", hl = "TSNamespace"},
--        Namespace = {icon = "", hl = "TSNamespace"},
--        Package = {icon = "", hl = "TSNamespace"},
--        Class = {icon = "𝓒", hl = "TSType"},
--        Method = {icon = "ƒ", hl = "TSMethod"},
--        Property = {icon = "", hl = "TSMethod"},
--        Field = {icon = "", hl = "TSField"},
--        Constructor = {icon = "", hl = "TSConstructor"},
--        Enum = {icon = "ℰ", hl = "TSType"},
--        Interface = {icon = "ﰮ", hl = "TSType"},
--        Function = {icon = "", hl = "TSFunction"},
--        Variable = {icon = "", hl = "TSConstant"},
--        Constant = {icon = "", hl = "TSConstant"},
--        String = {icon = "𝓐", hl = "TSString"},
--        Number = {icon = "#", hl = "TSNumber"},
--        Boolean = {icon = "⊨", hl = "TSBoolean"},
--        Array = {icon = "", hl = "TSConstant"},
--        Object = {icon = "⦿", hl = "TSType"},
--        Key = {icon = "🔐", hl = "TSType"},
--        Null = {icon = "NULL", hl = "TSType"},
--        EnumMember = {icon = "", hl = "TSField"},
--        Struct = {icon = "𝓢", hl = "TSType"},
--        Event = {icon = "🗲", hl = "TSType"},
--        Operator = {icon = "+", hl = "TSOperator"},
--        TypeParameter = {icon = "𝙏", hl = "TSParameter"}
--    }
--}
EOF
" nnoremap <space>v :SymbolsOutline<CR>
