return {
  "stevearc/aerial.nvim",
  lazy = true,
  -- stylua: ignore
  keys = function()
    local toggle = function() require("aerial").toggle({ focus = true }) end
    return {
      { "<space>o", toggle, noremap = true, desc = "Code outline" },
    }
  end,
  opts = {
    layout = {
      default_direction = "left",
      max_width = 30,
      min_width = 30,
    },
    -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#symbolKind
    -- filter_kind = {
    --   "Class",
    --   "Constructor",
    --   "Enum",
    --   "Function",
    --   "Interface",
    --   "Module",
    --   "Method",
    --   "Struct",
    --   "TypeParameter",
    -- }
    -- filter_kind = false
  },
}
