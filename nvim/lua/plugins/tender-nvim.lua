return {
  "jacoborus/tender.vim",
  config = function()
    vim.cmd.colorscheme "tender"
    vim.api.nvim_set_hl(0, "Statement",     { ctermfg = 81,  bold = true, nocombine = false })
    vim.api.nvim_set_hl(0, "Boolean",       { ctermfg = 215, bold = true, nocombine = false })
    vim.api.nvim_set_hl(0, "Function",      { ctermfg = 153, bold = true, nocombine = false })
    vim.api.nvim_set_hl(0, "MatchParen",    { ctermfg = 81 })
    vim.api.nvim_set_hl(0, "Operator",      { ctermfg = "NONE" })
    vim.api.nvim_set_hl(0, "Normal",        { ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "luaParenError", { link    = "Normal" })
    vim.api.nvim_set_hl(0, "ModeMsg",       { ctermfg = "NONE" })
    vim.api.nvim_set_hl(0, "SignColumn",    { ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "String",        { ctermfg = 78 })
  end
}
