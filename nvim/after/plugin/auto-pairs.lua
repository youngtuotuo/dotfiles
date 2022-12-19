require("nvim-autopairs").setup({
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

