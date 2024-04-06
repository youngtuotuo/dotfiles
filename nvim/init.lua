vim.loader.enable()

require("global")
require("opts")
require("keymaps")
require("aucmds")

-- lazy bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins
local opts = {
  change_detection = {
    notify = false
  },
  spec = {
    { import = "plugins" }, -- auto import lua/plugins/*.lua
  },
  ui = {
    border = _G.border,
    size = { width = 0.7, height = 0.5 },
    pills = false,
    icons = {
      cmd = "", -- " ",
      config = "", -- "",
      event = "", -- "",
      ft = "", -- " ",
      init = "", -- " ",
      import = "", -- " ",
      keys = "", -- " ",
      lazy = "", -- "󰒲 ",
      loaded = "", -- "●",
      not_loaded = "", -- "○",
      plugin = "", -- " ",
      runtime = "", -- " ",
      require = "", -- "󰢱 ",
      source = "", -- " ",
      start = "", -- "",
      task = "", --" ✔ ",
      list = {
        "", -- "●",
        "", -- "➜",
        "", -- "★",
        "", -- "‒",
      },
    },
  },
  default = { lazy = true },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "rplugin",
        "tarPlugin",
        "zipPlugin",
      },
    },
  },
}
require("lazy").setup(opts)
vim.api.nvim_create_user_command("L", "Lazy", {})
