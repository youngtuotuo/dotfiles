local M = {}

M.setup = function()
  local cmp_status_ok, cmp = pcall(require, "cmp")
  if not cmp_status_ok then return end

  local snip_status_ok, luasnip = pcall(require, "luasnip")
  if not snip_status_ok then return end

  local kind_status_ok, lspkind = pcall(require, "lspkind")
  if not kind_status_ok then return end

  require("luasnip.loaders.from_vscode").lazy_load()

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
               vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
                   :match("%s") == nil
  end

  require("cmp").setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      -- ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    enabled = function()
      -- disable completion in comments
      local context = require 'cmp.config.context'
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == 'c' then
        return true
      else
        return not context.in_treesitter_capture("comment") and
                   not context.in_syntax_group("Comment")
      end
    end,
    complettion = {autocomplete = false},
    formatting = {
      format = function(entry, vim_item)
        if vim.tbl_contains({'path'}, entry.source.name) then
          local icon, hl_group = require('nvim-web-devicons').get_icon(
                                     entry:get_completion_item().label)
          if icon then
            vim_item.kind = icon
            vim_item.kind_hl_group = hl_group
            return vim_item
          end
        end
        return lspkind.cmp_format({
          mode = 'symbol',
          with_text = false,
          maxwidth = 80, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          -- menu = ({
          --   buffer = "[Buffer]",
          --   nvim_lsp = "[Pyright]",
          --   luasnip = "[LuaSnip]",
          --   path = "[Path]",
          --   nvim_lua = "[NvimLua]",
          --   cmdline = "[Cmd]"
          -- })
        })(entry, vim_item)
      end
    },
    -- window = {
    --   completion = cmp.config.window.bordered(),
    --   documentation = cmp.config.window.bordered()
    -- },
    sources = cmp.config.sources({
      {name = 'nvim_lsp'}, {name = 'buffer'}, {name = 'luasnip', keyword_length = 3},
      {name = 'path'}, {name = 'nvim_lua'}
    }),
    sorting = {
      comparators = {cmp.config.compare.score, cmp.config.compare.offset}
    },
    experimental = {native_menu = false, ghost_text = false}
  })
  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = 'buffer'}}
  })
  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = 'path'}},
               {{name = 'cmdline', keyword_length = 3}})
  })
end

return M
