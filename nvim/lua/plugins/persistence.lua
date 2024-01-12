return {
  "folke/persistence.nvim",
  event = { "BufReadPre" },
  opts = { options = vim.opt.sessionoptions:get() },
  -- stylua: ignore
  keys = {
    { "<space>r", function() require("persistence").load() end, desc = "Restore Session" },
    -- { "<space>l", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    -- { "<space>d", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
  },
}
