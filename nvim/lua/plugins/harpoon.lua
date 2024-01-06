return {
  {
    "ThePrimeagen/harpoon",
    keys = {
      { "<leader>a", function() require("harpoon"):list():append() end },
      { "<leader>q", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end},
      { "<C-h>", function() require("harpoon"):list():select(1) end},
      { string.format("<M-%s>", 1), function() require("harpoon"):list():select(1) end },
      { string.format("<M-%s>", 2), function() require("harpoon"):list():select(2) end },
      { string.format("<M-%s>", 3), function() require("harpoon"):list():select(3) end },
      { string.format("<M-%s>", 4), function() require("harpoon"):list():select(4) end },
      { string.format("<M-%s>", 5), function() require("harpoon"):list():select(5) end },
    },
    branch = "harpoon2",
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
    end,
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
}
