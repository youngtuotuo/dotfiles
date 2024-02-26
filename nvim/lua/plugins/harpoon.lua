return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function(_, _)
    local hp = require("harpoon")
    hp:setup()
    local toggle = function()
      hp.ui:toggle_quick_menu(hp:list())
    end
    local append = function()
      hp:list():append()
    end
    local select1 = function()
      hp:list():select(1)
    end
    local select2 = function()
      hp:list():select(2)
    end
    local select3 = function()
      hp:list():select(3)
    end
    local select4 = function()
      hp:list():select(4)
    end
    local select5 = function()
      hp:list():select(5)
    end
    vim.keymap.set("n", "<space>q", toggle, { desc = "Harpoon toggle" })
    vim.keymap.set("n", "<space>a", append, { desc = "Harpoon add" })
    vim.keymap.set("n", "<space>1", select1, { desc = "Harpoon 1" })
    vim.keymap.set("n", "<space>2", select2, { desc = "Harpoon 2" })
    vim.keymap.set("n", "<space>3", select3, { desc = "Harpoon 3" })
    vim.keymap.set("n", "<space>4", select4, { desc = "Harpoon 4" })
    vim.keymap.set("n", "<space>5", select5, { desc = "Harpoon 5" })
  end,
  dependencies = { { "nvim-lua/plenary.nvim" } },
}
