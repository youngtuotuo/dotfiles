vim.cmd [[
  command! FormatJSON %!python -m json.tool
]]

-- avoid finger not leave shift
-- vim.api.nvim_create_user_command(
--  'W',
--  'call write',
-- )
-- vim.api.nvim_create_user_command(
--  'X',
--  'call xit',
-- )
-- vim.api.nvim_create_user_command(
--  'Q',
--  'call quit',
-- )

local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Telescope Stuff
keymap("n", "<space>r", ":Telescope lsp_references<CR>", default_opts)
keymap("n", "<space>f", ":Telescope current_buffer_fuzzy_find<CR>", default_opts)
keymap("n", "<space>g", ":Telescope git_files<CR>", default_opts)
keymap("n", "<space>d", ":Telescope diagnostics<CR>", default_opts)
keymap("n", "<space>b", ":Telescope buffers<CR>", default_opts)
keymap("n", "<space>c", ":Telescope commands<CR>", default_opts)
keymap("n", "<space>h", ":Telescope help_tags<CR>", default_opts)
keymap("n", "<space>m", ":Telescope keymaps<CR>", default_opts)
keymap("n", "<space>t", ":TodoTelescope cwd=.<CR>", default_opts)
keymap("n", "<space>v", ":Telescope lsp_document_symbols<CR>", default_opts)

-- g++ compile and execute
keymap("n", "<leader>g+", ":!g++ -std=c++11 -o vimpp.out % && ./vimpp.out<CR>", default_opts)
keymap("n", "<leader>gc", ":!gcc -o vimc.out % && ./vimc.out<CR>", default_opts)

-- James Powell python3
keymap("v", "<leader>p", ":w !python3<CR>", default_opts)
vim.cmd [[
  function! FullPy()
    let b:path=substitute(expand('%:r'), getcwd(), '', 'g') 
    let b:path=substitute(b:path, '/', '.', 'g') 
    execute "!" . "python3 -m " . b:path
  endfunction
]]
keymap("n", "<leader>p", ":call FullPy()<CR>", default_opts)

-- format python
keymap("n", "<leader>fp", "Neoformat black<CR>", default_opts)
-- format c/c++
keymap("n", "<leader>fc", ":Neoformat clang-format<CR>", default_opts)

-- esc to exit terminal mode
keymap("t", "<Esc>", "<C-\\><C-n>", default_opts)

-- Easier pane navigation
keymap("n", "<C-j>", "<C-w><C-j>", default_opts)
keymap("n", "<C-h>", "<C-w><C-h>", default_opts)
keymap("n", "<C-k>", "<C-w><C-k>", default_opts)
keymap("n", "<C-l>", "<C-w><C-l>", default_opts)

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

-- Quickfix list
keymap("n", "co", ":copen<CR>", default_opts)
keymap("n", "cc", ":cclose<CR>", default_opts)
keymap("n", "cn", ":cnext<CR>zz", default_opts)
keymap("n", "cp", ":cprev<CR>zz", default_opts)

-- ctrl-s to save
keymap("n", "<c-s>", ":w<CR>", default_opts)
keymap("v", "<c-s>", "<c-c>:w<CR>", default_opts)
keymap("i", "<c-s>", "<c-c>:w<CR>", default_opts)

-- bracket complete
keymap("i", "{<CR>", "{<CR>}<C-o>O", default_opts)
keymap("i", "(<CR>", "(<CR>)<C-o>O", default_opts)
keymap("i", "[<CR>", "[<CR>]<C-o>O", default_opts)

-- Undo break points
keymap("i", ",", ",<C-g>u", default_opts)
keymap("i", ".", ".<C-g>u", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("v", "K", ":move '<-2<CR>gv=gv", default_opts)
keymap("v", "J", ":move '>+1<CR>gv=gv", default_opts)

-- Resizing panes
keymap("n", "<S-Left>",   ":vertical resize +1<CR>", default_opts)
keymap("n", "<S-Right>",  ":vertical resize -1<CR>", default_opts)
keymap("n", "<S-Up>",     ":resize -1<CR>", default_opts)
keymap("n", "<S-Down>",   ":resize +1<CR>", default_opts)

-- netrw
keymap("n", "-", ":E<CR>", default_opts)
