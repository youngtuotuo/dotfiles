return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  lazy = true,
  -- stylua: ignore
  keys = function()
    local hp = require("harpoon")
    return {
      {"<space>q",  function() hp.ui:toggle_quick_menu(hp:list()) end, mode = "n", desc = "Harpoon toggle"},
      {"<space>a",  function() hp:list():append()                 end, mode = "n", desc = "Harpoon add"   },
      {"<space>1",     function() hp:list():select(1)                end, mode = "n", desc = "Harpoon 1"     },
      {"<space>2",     function() hp:list():select(2)                end, mode = "n", desc = "Harpoon 2"     },
      {"<space>3",     function() hp:list():select(3)                end, mode = "n", desc = "Harpoon 3"     },
      {"<space>4",     function() hp:list():select(4)                end, mode = "n", desc = "Harpoon 4"     },
      {"<space>5",     function() hp:list():select(5)                end, mode = "n", desc = "Harpoon 5"     },
    }
  end,
  config = function(_, _)
    require("harpoon"):setup()
  end,
  dependencies = { { "nvim-lua/plenary.nvim" } },
}
