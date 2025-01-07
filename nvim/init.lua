vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

vim.keymap.set({ "n" }, "d_", "d^", { nowait = true, noremap = true })
vim.keymap.set({ "n" }, "c_", "c^", { nowait = true, noremap = true })
vim.keymap.set({ "i" }, ",", "<C-g>u,", { noremap = true })
vim.keymap.set({ "i" }, ".", "<C-g>u.", { noremap = true })
vim.keymap.set({ "t" }, "<esc><esc>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set({ "n" }, "Y", "y$", { noremap = true })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true })

local group = vim.api.nvim_create_augroup("Tuo", { clear = true })
vim.api.nvim_create_autocmd("BufEnter",
  {
    group = group,
    callback = function(args)
      vim.treesitter.stop(args.buf)
    end
  }
)

vim.cmd.packadd [[cfilter]]

vim.g.fzf_layout = { down = [[40%]] }

local get_lan_ip = function()
  if vim.fn.has("mac") == 1 then
    local cmd = "ipconfig getifaddr en0"
    local ip = vim.fn.system(cmd):match("([%d%.]+)%\n")
    return ip
  elseif vim.fn.has("linux") == 1 or vim.fn.has("wsl") == 1 then
    local cmd = "ip route get 1.1.1.1 | awk '{print $7}'"
    local ip = vim.fn.system(cmd)
    return ip:gsub("%s+", "") -- Remove any leading/trailing whitespace
  end
end

vim.g.mkdp_auto_close = 0
vim.g.mkdp_open_to_the_world = 1
vim.g.mkdp_open_ip = get_lan_ip()
vim.g.mkdp_echo_preview_url = 1
vim.g.mkdp_port = "8085"
vim.g.mkdp_theme = "light"
