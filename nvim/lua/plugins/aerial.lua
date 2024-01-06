return {
  {
    "stevearc/aerial.nvim",
    event = "LspAttach",
    config = function()
      require("aerial").setup({
        layout = {
          default_direction = "left",
          max_width = 30,
          min_width = 30,
        },
      })
      vim.keymap.set("n", "<space>o", function()
        require("aerial").toggle({ focus = true })
      end, { noremap = true, silent = true })
    end,
  },
}
