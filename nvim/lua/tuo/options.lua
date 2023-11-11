local options = {
  -- indent
  autoindent = true,
  cindent = true,
  wrap = true,
  breakindent = true,
  showbreak = string.rep(" ", 3),
  linebreak = true,
  -- in case
  belloff = "all",
  backspace = "indent,eol,start",
  backup = false,
  completeopt = "menu,menuone,noinsert,noselect",
  cmdheight = 1,
  errorbells = false,
  expandtab = true,
  equalalways = false,
  fileencoding = "utf-8",
  fillchars = "stl: ,stlnc: ",
  guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50",
  hidden = true,
  -- search
  hlsearch = true,
  incsearch = true, -- Makes search act like search in modern browsers
  ignorecase = true, -- Ignore case when searching...
  laststatus = 0,
  matchtime = 1,
  mouse = "a",
  mousemoveevent = true,
  nu = false,
  pumheight = 7,
  rnu = false,
  ru = true,
  smoothscroll = true,
  scrolloff = 10,
  shiftwidth = 4,
  showcmd = true,
  smartcase = true, -- ... unless there is a capital letter in the query
  showmatch = true, -- show matching brackets when text indicator is over them
  showmode = true,
  signcolumn = "auto:1",
  smartindent = false,
  softtabstop = 4,
  splitbelow = true,
  splitright = true,
  splitkeep = "screen",
  swapfile = false,
  termguicolors = true,
  updatetime = 50,
  undofile = true,
  viminfo = "'1000",
  visualbell = false,
  wildignore = "__pycache__",
  writebackup = false,
}
vim.cmd [[
  set statusline=%{repeat('─',winwidth('.'))}
]]

vim.opt.pumblend = 0
vim.opt.wildmode = "full"
vim.opt.wildoptions = "pum"

for k, v in pairs(options) do
  vim.opt[k] = v
end
vim.opt.wildignore:append({ "*.o", "*~", "*.pyc", "*pycache*" })

-- highlight group for trailing white space
vim.cmd [[
  highlight default EoLSpace guibg=Red
  match EoLSpace /\s\+$/
  autocmd InsertEnter * hi EoLSpace guibg=NONE
  autocmd InsertLeave * hi EoLSpace guibg=Red
]]

local yank_augroup = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd([[startinsert]])
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})
vim.opt.formatoptions = vim.opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")
local home = "HOME"
local sep = "/"
if vim.fn.has("win32") == 1 then
  home = "USERPROFILE"
  sep = "\\"
  vim.cmd([[
    let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
    let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
    let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
    set shellquote= shellxquote=
  ]])
end
vim.opt.undodir = os.getenv(home) .. sep .. ".vim" .. sep .. "undodir"

vim.g.netrw_altfile = 1
vim.g.netrw_cursor = 5
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0

vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0

vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Wa", "wa", {})
vim.api.nvim_create_user_command("WA", "wa", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Qa", "qa", {})

-- mojo filetype
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.🔥", "*.mojo" },
  callback = function()
    if vim.opt_local.filetype ~= "mojo" then
      vim.opt_local.filetype = "mojo"
      vim.cmd [[ runtime syntax/python.vim ]]
      vim.cmd [[ runtime indent/python.vim ]]
      vim.cmd [[
        syn keyword mojoKeywords let var inout owned borrowed alias
        syn keyword mojoKeywords struct fn nextgroup=mojoName skipwhite
        syn match mojoName '\h\w*' display contained
        syn match mojoRefName '\h\w*&' display contains=mojoName
        syn region mojoDialect start="`" end="`" display

        hi def link mojoKeywords Keyword
        hi def link mojoRefName Identifier
        hi def link mojoDialect Special
      ]]
    end
  end,
})
