lua << EOF
--vim.lsp.set_log_level("debug")
EOF

lua << EOF
    require'lspconfig'.ccls.setup{}
    require'lspconfig'.pyright.setup{}
    require'lspconfig'.vimls.setup{}
    require'lspconfig'.cmake.setup{}
    require'lspconfig'.diagnosticls.setup{}
    require'lspconfig'.dockerls.setup{}
    require'lspconfig'.bashls.setup{}
    require'lspconfig'.cssls.setup{}
    require'lspconfig'.rust_analyzer.setup{}
EOF

lua << EOF
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
EOF

autocmd BufEnter * lua require'completion'.on_attach()
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

