local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end
local kind_status_ok, lspkind = pcall(require, "lspkind")
if not kind_status_ok then
  return
end

require("luasnip.loaders.from_vscode").lazy_load()

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local ELLIPSIS_CHAR = "…"
local MAX_LABEL_WIDTH = 40
local MIN_LABEL_WIDTH = 10
cmp.setup({
  -- completion = { autocomplete = false },
  window = {
    completion = { border = BORDER, scrollbar = false, max_width = 80, col_offset = 3 },
    documentation = { border = BORDER, scrollbar = false, max_width = 80 },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      local lspkind_ok, lspkind = pcall(require, "lspkind")
      if not lspkind_ok then
        -- From kind_icons array
        vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        -- Source
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[LaTeX]",
        })[entry.source.name]
        return vim_item
      else
        -- From lspkind
        return lspkind.cmp_format()(entry, vim_item)
      end
    end,
  },
  preselect = cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping(function(fallback)
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
    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    -- Accept currently selected item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<C-l>"] = cmp.mapping.confirm({ select = false }),
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
      return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
    end
  end,
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
  }, {
    { name = "path", keyword_length = 3 },
    { name = "nvim_lua" },
    { name = "nvim_lsp_signature_help" },
  }),
  sorting = {
    comparators = {
      cmp.config.compare.exact,
      cmp.config.compare.sort_text,
      cmp.config.compare.score,
      cmp.config.compare.kind,
      cmp.config.compare.offset,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  experimental = { ghost_text = false },
})
-- `/` cmdline setup.
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})
-- `:` cmdline setup.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = {
          "Man",
          "!",
          "write",
          "quit",
          "xit",
          "wall",
          "xall",
          "qall",
          "edit",
          "W",
          "Q",
          "ls",
          "bd",
        },
      },
    },
  }),
})
