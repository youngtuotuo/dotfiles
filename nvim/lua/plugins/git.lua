local check_git_repo = function()
    local output = vim.fn.systemlist("git rev-parse --is-inside-work-tree 2>/dev/null")
    return #output ~= 0
end
return {
    {
        "tpope/vim-fugitive",
        cond = check_git_repo,
        cmd = { "G", "Git" },
    },
}
