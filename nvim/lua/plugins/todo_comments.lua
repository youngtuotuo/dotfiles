return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "folke/trouble.nvim" },
  event = { "BufRead" },
  -- stylua: ignore
  keys = {
    {
      "<space>t", "<cmd>TroubleToggle todo cwd=", desc = "TodoTrouble"
    },
  },
  opts = {
    signs = false, -- show icons in the signs column
    sign_priority = 7, -- sign priority
    -- keywords recognized as todo comments
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "ERROR", "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = " ", color = "hint" },
      HACK = { icon = " ", color = "error" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = "󰖷 ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "info",    alt = { "INFO" } },
      TEST = { icon = " ", color = "test",    alt = { "TESTING", "PASSED", "FAILED" } },
      IDEA = { icon = " ", color = "test",    alt = { "TRY", "HINT", "THINK", "FEAT" } },
    },
    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
      multiline = false, -- enable multine todo comments
      multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
      multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
      before = "", -- "fg" or "bg" or empty
      keyword = "fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
      after = "", -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS)>.*:]], -- pattern or table of patterns, used for highlighting (vim regex)
      comments_only = true, -- uses treesitter to match keywords in comments only
      max_line_len = 400, -- ignore lines longer than this
      exclude = {}, -- list of file types to exclude highlighting
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of highlight groups or use the hex color if hl not found as a fallback
    colors = {
      error   = { "#DC2626" },
      warning = { "#FBBF24" },
      info    = { "#2563EB" },
      hint    = { "#10B981" },
      default = { "#7C3AED" },
      test    = { "#4499FF" },
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      pattern = [[\s\b(KEYWORDS):]], -- ripgrep regex
    },
  },
}
