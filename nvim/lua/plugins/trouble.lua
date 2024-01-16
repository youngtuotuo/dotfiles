return {
  "folke/trouble.nvim",
  lazy = true,
  cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
  keys = {
    { "<space>d", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "TroubleToggle workspace_diagnostics" },
    { "gr",       "<cmd>TroubleToggle lsp_references<cr>",        desc = "TroubleToggle lsp_references" },
  },
  opts = {
    padding = false,
    auto_fold = false,
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
      information = "info",
    },
    use_diagnostic_signs = false,
  },
}
