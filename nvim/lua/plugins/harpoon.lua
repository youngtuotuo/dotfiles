return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    -- stylua: ignore
    keys = {
      {"<leader>c", function() require("harpoon"):list():append() end, mode = "n"},
      {"<leader>q", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, mode = "n"},
      {"<M-1>", function() require("harpoon"):list():select(1) end, mode = "n"},
      {"<M-2>", function() require("harpoon"):list():select(2) end, mode = "n"},
      {"<M-3>", function() require("harpoon"):list():select(3) end, mode = "n"},
      {"<M-4>", function() require("harpoon"):list():select(4) end, mode = "n"},
    },
    config = function(_, opts)
      require("harpoon"):setup()
    end,
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
}
