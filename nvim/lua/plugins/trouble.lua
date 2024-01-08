return {
  "folke/trouble.nvim",
  events = "LspAttach",
  keys = {
    { "co", "<cmd>TroubleToggle<cr>" }
  },
  opts = {
    padding = false,
    auto_fold = true,
    win_config = { border = BORDER },
    icons = false,
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    indent_lines = false, -- add an indent guide below the fold icons
    signs = {
      -- icons / text used for a diagnostic
      error = "error",
      warning = "warn",
      hint = "hint",
      information = "info"
    },
    use_diagnostic_signs = false,
  },
}
