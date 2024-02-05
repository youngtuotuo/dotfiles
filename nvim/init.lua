local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
  local watch_type = require("vim._watch").FileChangeType

  local function handler(res, callback)
    if not res.files or res.is_fresh_instance then
      return
    end

    for _, file in ipairs(res.files) do
      local path = res.root .. "/" .. file.name
      local change = watch_type.Changed
      if file.new then
        change = watch_type.Created
      end
      if not file.exists then
        change = watch_type.Deleted
      end
      callback(path, change)
    end
  end

  local function watchman(path, opts, callback)
    vim.system({ "watchman", "watch", path }):wait()

    local buf = {}
    local sub = vim.system({
      "watchman",
      "-j",
      "--server-encoding=json",
      "-p",
    }, {
      stdin = vim.json.encode({
        "subscribe",
        path,
        "nvim:" .. path,
        {
          expression = { "anyof", { "type", "f" }, { "type", "d" } },
          fields = { "name", "exists", "new" },
        },
      }),
      stdout = function(_, data)
        if not data then
          return
        end
        for line in vim.gsplit(data, "\n", { plain = true, trimempty = true }) do
          table.insert(buf, line)
          if line == "}" then
            local res = vim.json.decode(table.concat(buf))
            handler(res, callback)
            buf = {}
          end
        end
      end,
      text = true,
    })

    return function()
      sub:kill("sigint")
    end
  end

  if vim.fn.executable("watchman") == 1 then
    wf._watchfunc = watchman
  else
    wf._watchfunc = function()
      return function() end
    end
  end
end
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
  spec = {
    { import = "plugins" }, -- auto import lua/plugins/*.lua
  },
  ui = {
    border = _G.border,
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
        -- "tutor",
        "zipPlugin",
      },
    },
  },
}
require("lazy").setup(opts)
vim.api.nvim_create_user_command("L", "Lazy", {})

-- for auto update colorscheme, always keep this at the last line
vim.cmd([[colo rose-pine]])
