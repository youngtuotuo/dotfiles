return {
  "folke/trouble.nvim",
  lazy = true,
  keys = {
    { "<space>d", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "TroubleToggle workspace_diagnostics" },
    { "<space>r", "<cmd>TroubleToggle lsp_references<cr>",        desc = "TroubleToggle lsp_references" },
  },
  opts = {
    padding = false,
    auto_fold = false,
    win_config = { border = _G.border },
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
