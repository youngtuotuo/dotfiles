return {
  "cshuaimin/ssr.nvim",
  main = "ssr",
  keys = {
    {
      "<space>v", function() require("ssr").open() end, mode = { "n", "x"}
    }
  },
  opts = {
    keymaps = {
      close = "q",
      next_match = "n",
      prev_match = "N",
      replace_confirm = "<cr>",
      replace_all = "<leader><cr>",
    },
  },
}
