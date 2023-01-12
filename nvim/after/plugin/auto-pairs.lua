require("nvim-autopairs").setup({
    disable_filetype = {"TelescopePrompt"},
    fast_wrap = {
        map = '<leader>e',
        chars = {'{', '[', '(', '"', "'"},
        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment'
    }
})

