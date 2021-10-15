lua << EOF
-- Setup nvim-cmp.
local lspkind = require('lspkind')
local cmp = require'cmp'
local WIDE_HEIGHT = 35
cmp.setup({
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    formatting = {
      format = lspkind.cmp_format({with_text = false, maxwidth = 50})
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = 'NormalFloat:NormalFloat,FloatBorder:NormalFloat',
      maxwidth = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
      maxheight = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
    },
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body)

        -- For `luasnip` user.
        -- require('luasnip').lsp_expand(args.body)

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
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      { name = 'vsnip' },

      -- For luasnip user.
      -- { name = 'luasnip' },

      -- For ultisnips user.
      -- { name = 'ultisnips' },

      { name = 'buffer' },
    }
})

EOF
