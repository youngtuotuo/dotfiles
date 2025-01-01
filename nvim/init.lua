vim.cmd.colo [[vividchalk]]
vim.opt.statusline = [[%<%f %h%w%m%r  - %{g:colors_name} - %{FugitiveStatusline()}%=%-14.(%l,%c%V%) %P]]
vim.opt.completeopt = [[menu,preview,fuzzy]]
vim.opt.fillchars:append("vert:|,fold:-,eob:~")
vim.opt.foldopen:remove([[block]])
vim.opt.inccommand = "split"
vim.opt.laststatus = 2
vim.opt.listchars:append([[eol:$]])
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shada = { "'10", "<0", "s10", "h" }
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
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
vim.keymap.set({ "v" }, "p", [["_dP]], { noremap = true })
vim.keymap.set({ "v" }, "<", "<gv", { noremap = true })
vim.keymap.set({ "v" }, ">", ">gv", { noremap = true })

local group = vim.api.nvim_create_augroup("Tuo", { clear = true })
vim.api.nvim_create_autocmd("BufEnter",
  {
    group = group,
    callback = function(args)
      vim.treesitter.stop(args.buf)
    end
  }
)
vim.api.nvim_create_autocmd("TextYankPost",
  {
    group = group,
    callback = function()
      vim.highlight.on_yank()
    end
  }
)

vim.cmd.packadd [[cfilter]]

if vim.fn.has("win32") == 1 then
  vim.opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
  vim.opt.shellcmdflag = "-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
  vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

vim.g.fzf_layout = { down = [[40%]] }

local get_lan_ip = function()
  if vim.fn.has("win32") == 1 then
    local output = vim.fn.system("ipconfig")
    local lan_ip = output:match("IPv4 Address.-:%s192([%d%.]+)")
    return "192" .. lan_ip
  elseif vim.fn.has("mac") == 1 then
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

-- from tpope/vim-ragtag
local function is_filetype(ft)
  local filetypes = vim.split(vim.bo.filetype, ".", true)
  for _, v in ipairs(filetypes) do
    if v == ft then
      return true
    end
  end
  return false
end

local function get_subtype()
  local top = vim.fn.getline(1) .. "\n" .. vim.fn.getline(2)
  local ft = vim.bo.filetype

  if (string.find(top, "<?xml>") and not string.match(ft:lower(), "html")) 
    or string.match(ft:lower(), "^(xml|xsd|xslt|docbk)$") then
    return "xml"
  elseif string.match(top:lower(), "<xhtml>") then
    return "xhtml"
  elseif string.match(top:lower(), "<!DOCTYPE html>") then
    return "html5"
  elseif string.match(top:lower(), "[^<]<html>") then
    return "html"
  elseif is_filetype("xhtml") then
    return "xhtml"
  else
    return ""
  end
end


-- Helper functions for style and script tags
local function stylesheet_type()
  if get_subtype() == "html5" then
    return ""
  else
    return ' type="text/css"'
  end
end

local function javascript_type()
  if get_subtype() == "html5" then
    return ""
  else
    return ' type="text/javascript"'
  end
end

-- Main function to get tag extras
local function tag_extras()
  local subtype = get_subtype()
  local register = vim.fn.getreg('"')

  if subtype == "xml" then
    return ""
  elseif register == "html" and subtype == "xhtml" then
    local lang = "en"
    local env_lang = vim.env.LANG
    if env_lang and string.match(env_lang, "^..") then
      lang = string.sub(env_lang, 1, 2)
    end
    return string.format(' xmlns="http://www.w3.org/1999/xhtml" lang="%s" xml:lang="%s"', lang, lang)
  elseif register == "style" then
    return stylesheet_type()
  elseif register == "script" then
    return javascript_type()
  elseif register == "table" then
    return ' cellspacing="0"'
  else
    return ""
  end
end

-- Set up the keymaps
local opts = { noremap = true, silent = true }

-- Helper function to wrap text in tags
local function wrap_in_tag()
  local reg = vim.fn.getreg('"')
  local extras = tag_extras()
  return string.format("<%s%s></%s>", reg, extras, reg)
end

-- <C-X><Space> mapping
vim.keymap.set('i', '<C-X><Space>', function()
  vim.cmd('normal! ciw')
  local wrapped = wrap_in_tag()
  vim.api.nvim_put({wrapped}, 'c', false, true)
  vim.cmd('normal! F<i')
end, opts)

-- <C-X><CR> mapping
vim.keymap.set('i', '<C-X><CR>', function()
  vim.cmd('normal! ciw')
  local wrapped = wrap_in_tag()
  local lines = vim.split(wrapped, '><')
  lines[1] = lines[1] .. '>'
  lines[2] = '<' .. lines[2]
  vim.api.nvim_put(lines, 'l', false, true)
  vim.cmd('normal! k$o')
end, opts)
