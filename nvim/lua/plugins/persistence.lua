return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    -- stylua: ignore
    keys = {
      { "<leader>r", function() require("persistence").load() end, desc = "Restore Session" },
      -- { "<leader>l", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      -- { "<leader>d", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
}
