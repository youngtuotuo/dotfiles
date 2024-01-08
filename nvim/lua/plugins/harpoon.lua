return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      vim.keymap.set("n", "<leader>c", function()
        harpoon:list():append()
      end)
      vim.keymap.set("n", "<leader>q", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set("n", "<M-1>", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<M-2>", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<M-3>", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<M-4>", function()
        harpoon:list():select(4)
      end)
    end,
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
}
