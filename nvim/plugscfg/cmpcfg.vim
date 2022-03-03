lua << EOF
-- Setup nvim-cmp.
vim.opt.completeopt = {"menu", "menuone", "noselect"}
local cmp = require'cmp'
cmp.setup({
    formatting={},
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        -- vim.fn["vsnip#anonymous"](args.body)

        -- For `luasnip` user.
        --require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        -- vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        --['<C-Space>'] = cmp.mapping.complete(),
        ['<esc>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
         behavior = cmp.ConfirmBehavior.Replace,
         select = true 
      }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      --{ name = 'path' },
      --{ name = 'luasnip' },
    },{
      { name = 'buffer' },
      { name = 'treesitter' },
    }),
    experimental = {
      native_menu = false,
      ghost_text = false,
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
            { name = 'buffer' }
        }
    })
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--cmp.setup.cmdline(':', {
--sources = cmp.config.sources({
--      { name = 'path' }
--    }, {
--      { name = 'cmdline' }
--    })
--})
EOF
