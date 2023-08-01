-- this cause pyright frequently lag
-- temporay solution
local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
  -- disable lsp watcher. Too slow on linux
  wf._watchfunc = function()
    return function() end
  end
end
vim.loader.enable()
require("tuo.options")
require("tuo.keymaps")
require("tuo.useful")
require("tuo.lazy")

