return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function(_, _)
    local hp = require("harpoon")
    hp:setup()
    vim.keymap.set("n", "<space>q",  function() hp.ui:toggle_quick_menu(hp:list()) end, { desc = "Harpoon toggle"})
    vim.keymap.set("n", "<space>a",  function() hp:list():append()                 end, { desc = "Harpoon add"   })
    vim.keymap.set("n", "<space>1",  function() hp:list():select(1)                end, { desc = "Harpoon 1"     })
    vim.keymap.set("n", "<space>2",  function() hp:list():select(2)                end, { desc = "Harpoon 2"     })
    vim.keymap.set("n", "<space>3",  function() hp:list():select(3)                end, { desc = "Harpoon 3"     })
    vim.keymap.set("n", "<space>4",  function() hp:list():select(4)                end, { desc = "Harpoon 4"     })
    vim.keymap.set("n", "<space>5",  function() hp:list():select(5)                end, { desc = "Harpoon 5"     })
  end,
  dependencies = { { "nvim-lua/plenary.nvim" } },
}
