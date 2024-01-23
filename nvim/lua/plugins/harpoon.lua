return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function(_, _)
    local hp = require("harpoon")
    hp:setup()
    local keyms = {
      { "n", "hq",  function() hp.ui:toggle_quick_menu(hp:list()) end, { desc = "Harpoon toggle"} },
      { "n", "ha",  function() hp:list():append()                 end, { desc = "Harpoon add"   } },
      { "n", "h1",  function() hp:list():select(1)                end, { desc = "Harpoon 1"     } },
      { "n", "h2",  function() hp:list():select(2)                end, { desc = "Harpoon 2"     } },
      { "n", "h3",  function() hp:list():select(3)                end, { desc = "Harpoon 3"     } },
      { "n", "h4",  function() hp:list():select(4)                end, { desc = "Harpoon 4"     } },
      { "n", "h5",  function() hp:list():select(5)                end, { desc = "Harpoon 5"     } }
    }
    for _, v in ipairs(keyms) do
      vim.keymap.set(unpack(v))
    end
  end,
  dependencies = { { "nvim-lua/plenary.nvim" } },
}
