lua << EOF
--vim.lsp.set_log_level("debug")
EOF
highlight NormalFloat guifg=NONE guibg=#1b212d
highlight FloatBorder guifg=NONE guibg=#1b212d
highlight LspReferenceText guifg=NONE gui=standout
highlight LspReferenceRead guifg=NONE gui=standout
highlight LspReferenceWrite guifg=NONE gui=standout

lua << EOF
--vim.api.nvim_command [[autocmd CursorHold  * lua vim.lsp.buf.document_highlight()]]
--vim.api.nvim_command [[autocmd CursorHoldI * lua vim.lsp.buf.document_highlight()]]
local protocol = require'vim.lsp.protocol'
protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
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
vim.api.nvim_command [[autocmd CursorMoved * lua vim.lsp.buf.clear_references()]]
--local border = {
--    { "╭", "NormalFloat" },
--    { "─", "NormalFloat" },
--    { "╮", "NormalFloat" },
--    { "│", "NormalFloat" },
--    { "╯", "NormalFloat" },
--    { "─", "NormalFloat" },
--    { "╰", "NormalFloat" },
--    { "│", "NormalFloat" },
--}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local custom_on_attach = function(client, bufnr)
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single"})

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
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

--local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Code actions
--capabilities.textDocument.codeAction = {
--  dynamicRegistration = false;
--      codeActionLiteralSupport = {
--          codeActionKind = {
--              valueSet = {
--                 "",
--                 "quickfix",
--                 "refactor",
--                 "refactor.extract",
--                 "refactor.inline",
--                 "refactor.rewrite",
--                 "source",
--                 "source.organizeImports",
--              };
--          };
--      };
--}

-- Snippets
--capabilities.textDocument.completion.completionItem.snippetSupport = true;

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local nvim_lsp = require('lspconfig')
local servers = { 'pyright', 'vimls', 'bashls', 'yamlls' }
-- 'cmake', 'diagnosticls', 'dockerls'
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    --capabilities = capabilities,
    on_attach = custom_on_attach,
    init_options = {
        onlyAnalyzeProjectsWithOpenFiles = false,
        suggestFromUnimportedLibraries = true,
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
    vim.lsp.handlers[method] = function(err, method, result, client_id, bufnr,
                                        config)
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
    underline = false,
    -- This sets the spacing and the prefix, obviously.
    --virtual_text = false,
    signs = true,
    update_in_insert=false,
    virtual_text = {
      spacing = 4,
      source = "always",
    }
  }
)
--local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
local signs = { Error = "", Warn = "", Hint = "", Info = "" }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, linehl = "", numhl = "" })
end
EOF
" highlight DiagnosticSignError guifg=Red
" highlight DiagnosticSignWarn guifg=Red
" highlight DiagnosticSignInfo guifg=Yellow
" highlight DiagnosticSignHint guifg=NONE

" sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl=NONE numhl=NONE
" sign define DiagnosticSignWarn text=  texthl=DiagnosticSignWarn linehl=NONE numhl=NONE
" sign define DiagnosticSignInfo text=  texthl=DiagnosticSignInfo linehl=NONE numhl=NONE
" sign define DiagnosticSignHint text=  texthl=DiagnosticSignHint linehl=NONE numhl=NONE
lua << EOF
-- not activated list
-- symbols-outline.nvim
--vim.g.symbols_outline = {
--    highlight_hovered_item = true,
--    show_guides = true,
--    auto_preview = false, -- experimental
--    position = 'right',
--    keymaps = {
--        close = "<Esc>",
--        goto_location = "<Cr>",
--        focus_location = "o",
--        hover_symbol = "<C-space>",
--        rename_symbol = "r",
--        code_actions = "a"
--    },
--    lsp_blacklist = {}
--}

--local custom_on_attach = function(client, bufnr)
--  --formatting
--  if client.resolved_capabilities.document_formatting then
--    vim.api.nvim_command [[augroup Format]]
--    vim.api.nvim_command [[autocmd! * <buffer>]]
--    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
--    vim.api.nvim_command [[augroup END]]
--  end
--  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
--end
-- Show line diagnostics automatically in hover window
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
--vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

-- go to definition in a split window
--local function goto_definition(split_cmd)
--  local util = vim.lsp.util
--  local log = require("vim.lsp.log")
--  local api = vim.api
--
--  -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
--  local handler = function(_, result, ctx)
--    if result == nil or vim.tbl_isempty(result) then
--      local _ = log.info() and log.info(ctx.method, "No location found")
--      return nil
--    end
--
--    if split_cmd then
--      vim.cmd(split_cmd)
--    end
--
--    if vim.tbl_islist(result) then
--      util.jump_to_location(result[1])
--
--      if #result > 1 then
--        util.set_qflist(util.locations_to_items(result))
--        api.nvim_command("copen")
--        api.nvim_command("wincmd p")
--      end
--    else
--      util.jump_to_location(result)
--    end
--  end
--
--  return handler
--end
--
--vim.lsp.handlers["textDocument/definition"] = goto_definition('vsplit')

-- Print diagnostics in status line
--function PrintDiagnostics(opts, bufnr, line_nr, client_id)
--  opts = opts or {}
--
--  bufnr = bufnr or 0
--  line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
--
--  local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
--  if vim.tbl_isempty(line_diagnostics) then return end
--
--  local diagnostic_message = ""
--  for i, diagnostic in ipairs(line_diagnostics) do
--    diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
--    print(diagnostic_message)
--    if i ~= #line_diagnostics then
--      diagnostic_message = diagnostic_message .. "\n"
--    end
--  end
--  vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
--end
--
--vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]
EOF
