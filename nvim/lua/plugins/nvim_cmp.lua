return {
  {
    "hrsh7th/nvim-cmp",
    event = { "LspAttach" },
    dependencies = {
      "hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words
      "FelipeLema/cmp-async-path", -- nvim-cmp source for path (async version)
      { "L3MON4D3/LuaSnip", version = "v2.*" }, -- Snippet Engine for Neovim written in Lua
      "saadparwaiz1/cmp_luasnip", -- luasnip completion source for nvim-cmp
      "hrsh7th/cmp-nvim-lua", -- nvim-cmp source for neovim Lua API.
      "hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim's built-in language server client.
      "hrsh7th/cmp-nvim-lsp-signature-help", -- nvim-cmp source for displaying function signatures with the current parameter emphasized:
    },
    config = function()
      vim.opt.pumheight = 15
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if not cmp_status_ok then
        return
      end

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s")
            == nil
      end

      cmp.setup({
        -- completion = { autocomplete = false },
        view = {
          docs = { auto_open = true },
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.abbr = string.sub(vim_item.abbr, 1, 30)
            vim_item.menu = ({
              buffer = "cmp_buffer",
              nvim_lsp = "nvim_lsp",
              luasnip = "luasnip",
              nvim_lua = "nvim_lua",
              nvim_lsp_signature_help = "nvim_sig",
              latex_symbols = "laTeX",
            })[entry.source.name]
            return vim_item
          end,
        },
        window = {
          completion = {
            winhighlight = "", -- keep this
            scrollbar = false,
            border = BORDER,
            max_width = 40,
          },
          documentation = { scrollbar = false, border = BORDER, max_width = 40, max_height = 30 },
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        preselect = cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-5),
          ["<C-f>"] = cmp.mapping.scroll_docs(5),
          ["<C-l>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
          ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
        }),
        enabled = function()
          -- disable completion in comments
          local context = require("cmp.config.context")
          local tele_prompt = vim.bo.filetype == "TelescopePrompt"
          -- keep command mode completion enabled when cursor is in a comment
          if vim.api.nvim_get_mode().mode == "c" then
            return true
          elseif tele_prompt then
            return false
          else
            return not context.in_treesitter_capture("comment")
              and not context.in_syntax_group("Comment")
          end
        end,
        sources = cmp.config.sources({
          { name = "luasnip" },
          { name = "async_path", keyword_length = 3 },
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
        }, {
          { name = "buffer" },
          { name = "nvim_lua" }, -- nvim lua api
        }),
        sorting = {
          priority_weight = 1.0,
          comparators = {
            cmp.config.compare.locality,
            cmp.config.compare.recently_used,
            cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
            cmp.config.compare.offset,
            cmp.config.compare.order,
          },
        },
        experimental = { ghost_text = false },
      })
    end,
  },
}
