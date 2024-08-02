return {
  "jacoborus/tender.vim",
  config = function()
    vim.cmd.colorscheme "tender"
    vim.api.nvim_set_hl(0, "MatchParen",    { link = "Statement" })
    vim.api.nvim_set_hl(0, "Operator",      { link = "Normal" })
    vim.api.nvim_set_hl(0, "Normal",        { ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "luaParenError", { ctermfg = "NONE" })
    vim.api.nvim_set_hl(0, "ModeMsg",       { ctermfg = "NONE" })
    vim.api.nvim_set_hl(0, "SignColumn",    { ctermbg = "NONE" })
  end
}
