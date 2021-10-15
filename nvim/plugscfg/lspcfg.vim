lua << EOF
--vim.lsp.set_log_level("debug")
EOF

lua << EOF
--vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#627085]]
--vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#627085]]
--
--local border = {
--      {"╭", "FloatBorder"},
--      {"─", "FloatBorder"},
--      {"╮", "FloatBorder"},
--      {"│", "FloatBorder"},
--      {"╯", "FloatBorder"},
--      {"─", "FloatBorder"},
--      {"╰", "FloatBorder"},
--      {"│", "FloatBorder"},
--}
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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local custom_on_attach = function(client, bufnr)
  --require('completion').on_attach()
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
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
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  --buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- formatting
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end

  if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi LspReferenceText cterm=bold ctermbg=red guibg=#585e75
        hi LspReferenceRead cterm=bold ctermbg=red guibg=#585e75
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=#585e75
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
  end

  --vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border})
  --vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border})

end

-- symbols-outline.nvim
vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false, -- experimental
    position = 'right',
    keymaps = {
        close = "<Esc>",
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        rename_symbol = "r",
        code_actions = "a"
    },
    lsp_blacklist = {}
}

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
local servers = { 'pyright', 'vimls', 'cmake', 'diagnosticls', 'dockerls', 'bashls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities;
    on_attach = custom_on_attach;
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


-- diagnostic after each line
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = false,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = false,
    signs = true,
    update_in_insert=false,
    --virtual_text = {
    --  spacing = 4,
    --  prefix = ''
    --}
  }
)
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

-- Show line diagnostics automatically in hover window
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 100
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]
EOF

sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsDefaultError
sign define LspDiagnosticsSignWarning text=  texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsDefaultWarning
sign define LspDiagnosticsSignInformation text=  texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsDefaultInformation
sign define LspDiagnosticsSignHint text=  texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsDefaultHint
