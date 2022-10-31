-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}
local term_opts = {silent = true}
local expr_opts = {noremap = true, expr = true, silent = true}

-- Modes
-- normal_mode = "n"
-- insert_mode = "i"
-- visual_mode = "v"
-- visual_block_mode = "x"
-- term_mode = "t"
-- command_mode = "c"

-- Vimtex
keymap("n", "<leader>vc", ":VimtexCompile<CR>", default_opts)

-- Telescope Stuff
keymap("n", "<space>r", ":Telescope lsp_references<CR>", default_opts)
keymap("n", "<space>e", ":Telescope find_files<CR>", default_opts)
keymap("n", "<space>f", ":Telescope current_buffer_fuzzy_find<CR>", default_opts)
keymap("n", "<space>g", ":Telescope git_files<CR>", default_opts)
keymap("n", "<space>d", ":Telescope diagnostics<CR>", default_opts)
keymap("n", "<space>l", ":Telescope live_grep<CR>", default_opts)
keymap("n", "<space>b", ":Telescope buffers<CR>", default_opts)
keymap("n", "<space>c", ":Telescope commands<CR>", default_opts)
keymap("n", "<space>h", ":Telescope help_tags<CR>", default_opts)
keymap("n", "<space>m", ":Telescope keymaps<CR>", default_opts)
keymap("n", "<space>n", ":Telescope notify<CR>", default_opts)
keymap("n", "<space>t", ":TodoTelescope cwd=.<CR>", default_opts)
keymap("n", "<space>v", ":Telescope lsp_document_symbols<CR>", default_opts)
keymap("n", "<space>w", ":Telescope workspaces<CR>", default_opts)

-- TreeSitter highlight toggle
keymap("n", "<leader>ts", ":TSToggle highlight<CR>", default_opts)

-- g++ compile and execute
local ext = ""
local sep = "/"
if vim.fn.has("win32") == 1 then
  ext = ".exe"
  sep = "\\"
end
keymap("n", "<leader>c+", ":!clang++ -Wall -std=c++14 -o vimcpp.out" .. ext .. " % && ." .. sep .. "vimcpp.out" .. ext .. "<CR>",
       default_opts)
keymap("n", "<leader>c", ":!clang -Wall -o vimc.out" .. ext .. " % && ." .. sep .. "vimc.out" .. ext .. "<CR>", default_opts)

-- James Powell python3
-- TODO windows path is a little different
keymap("v", "<leader>p", ":w !python<CR>", default_opts)
keymap("n", "<leader>p", ":!python %<CR>", default_opts)

-- auto complete
-- keymap("i", "{<CR>", "{<CR>}<Esc>O", default_opts)
-- keymap("i", "[<CR>", "[<CR>]<Esc>O", default_opts)
-- keymap("i", "(<CR>", "(<CR>)<Esc>O", default_opts)

-- <C-c> will raise interrupted error of lsp
keymap("n", "<C-c>", "<Esc>", default_opts)

-- Not show native menu
keymap("i", "<C-n>", "<Nop>", default_opts)
keymap("i", "<C-p>", "<Nop>", default_opts)

-- Easier pane navigation
keymap("n", "<C-j>", "<C-w>j", default_opts)
keymap("n", "<C-h>", "<C-w>h", default_opts)
keymap("n", "<C-k>", "<C-w>k", default_opts)
keymap("n", "<C-l>", "<C-w>l", default_opts)

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
-- esc to exit terminal mode
keymap("t", "<Esc>", "<C-\\><C-n>", term_opts)

-- number line
keymap("n", "<leader>ss", ":set invnu invrnu<CR>", default_opts)

-- Tab navigation like Firefox.
keymap("n", "tj", ":tabprevious<CR>", default_opts)
keymap("n", "tk", ":tabnext<CR>", default_opts)
keymap("n", "tn", ":tabnew<CR>", default_opts)

-- Y like C,D
keymap("n", "Y", "y$", default_opts)
keymap("n", "J", "mzJ`z", default_opts)
keymap("n", "n", "nzzzv", default_opts)
keymap("n", "N", "Nzzzv", default_opts)

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

vim.cmd [[
  command! FormatJSON %!python -m json.tool
]]
-- NvimTree
vim.cmd [[
  command! E NvimTreeToggle
]]

-- Jump list mutations
vim.cmd [[
  nnoremap <expr> k (v:count > 5 ? "m'" . v:count: "") . 'k'
  nnoremap <expr> j (v:count > 5 ? "m'" . v:count: "") . 'j'
]]

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- Move selected line / block of text in visual mode
keymap("v", "K", ":move .-2<CR>==", default_opts)
keymap("v", "J", ":move .+1<CR>==", default_opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Quickfix list
keymap("n", "co", ":copen<CR>", default_opts)
keymap("n", "cc", ":cclose<CR>", default_opts)
keymap("n", "cn", ":cnext<CR>zz", default_opts)
keymap("n", "cp", ":cprev<CR>zz", default_opts)

-- Undo break points
keymap("i", ",", ",<C-g>u", default_opts)
keymap("i", ".", ".<C-g>u", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohl<CR>", default_opts)

-- Resizing panes
keymap("n", "<S-Left>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<S-Right>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<S-Up>", ":resize +1<CR>", default_opts)
keymap("n", "<S-Down>", ":resize -1<CR>", default_opts)
