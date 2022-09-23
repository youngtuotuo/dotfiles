require("luasnip.loaders.from_vscode").lazy_load()

local luasnip = require("luasnip")
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
  enabled = true,
  complettion = {autocomplete = false},
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 20,
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        path = "[PATH]"
      })
    })
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end
  },
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, {"i", "s"}),
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, {"i", "s"}),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {"i", "s"}),
    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {"i", "s"}),
    ['<Down>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, {"i", "s"}),
    ['<Up>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {"i", "s"}),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    ['<esc>'] = cmp.config.disable,
    ['<CR>'] = cmp.mapping.confirm({select = false})
  },
  sources = cmp.config.sources({
    {name = 'nvim_lsp'}, {name = 'buffer'}, {name = 'luasnip'},
    {name = 'nvim_lsp_signature_help'}, {name = 'path'}, {name = 'nvim_lua'}
  }),
  sorting = {
    comparators = {cmp.config.compare.score, cmp.config.compare.offset}
  },
  experimental = {native_menu = false, ghost_text = true}
})

