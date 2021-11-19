lua << EOF
-- Setup nvim-cmp.
vim.opt.completeopt = {"menu", "menuone", "noselect"}
local lspkind = require('lspkind')
local cmp = require'cmp'
local WIDE_HEIGHT = 30
local WIDE_WIDTH = 30
cmp.setup({
    formatting = {
      format = lspkind.cmp_format {
        maxwidth = 40,
        with_text = true,
        menu = {
          buffer = "[BUF]",
          nvim_lsp = "[LSP]",
          path = "[PATH]",
          --vsnip = "[VSNIP]",
          luasnip = "[LuaSnip]",
        },
      },
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = 'NormalFloat:NormalFloat,FloatBorder:NormalFloat',
      maxwidth = math.floor((WIDE_WIDTH) * (vim.o.columns / (WIDE_WIDTH * 2 / 9))),
      maxheight = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
    },
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        -- vim.fn["vsnip#anonymous"](args.body)

        -- For `luasnip` user.
        require('luasnip').lsp_expand(args.body)

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
      { name = 'path' },
      { name = 'buffer' },
      { name = 'luasnip' },
      --{ name = 'vsnip' },

    },
    experimental = {
      native_menu = false,
      ghost_text = true,
    },
})

EOF
