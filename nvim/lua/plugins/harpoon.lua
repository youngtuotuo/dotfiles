return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function(_, _)
    local hp = require("harpoon")
    hp:setup()
    local keyms = {
      { "n", "<space>q",  function() hp.ui:toggle_quick_menu(hp:list()) end, { desc = "Harpoon toggle" } },
      { "n", "<space>a",  function() hp:list():append()                 end, { desc = "Harpoon add"    } },
      { "n", "<space>1",  function() hp:list():select(1)                end, { desc = "Harpoon 1"      } },
      { "n", "<space>2",  function() hp:list():select(2)                end, { desc = "Harpoon 2"      } },
      { "n", "<space>3",  function() hp:list():select(3)                end, { desc = "Harpoon 3"      } },
      { "n", "<space>4",  function() hp:list():select(4)                end, { desc = "Harpoon 4"      } },
      { "n", "<space>5",  function() hp:list():select(5)                end, { desc = "Harpoon 5"      } }
    }
    for _, v in ipairs(keyms) do
      vim.keymap.set(unpack(v))
    end
  end,
  dependencies = { { "nvim-lua/plenary.nvim" } },
}
