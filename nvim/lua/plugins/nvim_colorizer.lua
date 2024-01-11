return {
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    -- opts = {}, -- don't use this
    config = function()
      require("colorizer").setup()
    end
  },
}
