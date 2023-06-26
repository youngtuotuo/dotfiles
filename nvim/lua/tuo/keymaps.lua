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
-- command_mode = "c"
-- term_mode = "t"

keymap("n", "-", ":E<cr>", default_opts)
-- <leader>p for exucute python, c, c++
local ext = ""
local sep = "/"
local py = "python3"
local c = "gcc -Wall -o main"
local cpp = "g++ -Wall -std=c++14 -o main"
---- different system needs different name
if vim.fn.has("win32") == 1 then
    ext = ".exe"
    sep = "\\"
    py = "python"
elseif vim.fn.has("mac") == 1 then
    c = "clang -Wall -o main"
    cpp = "clang++ -Wall -std=c++14 -o main"
end
local cmd = ""
---- deafult is python
keymap("n", "<leader>p", ":!" .. py .. "<CR>", default_opts)
keymap("v", "<leader>p", ":w !" .. py .. "<CR>", default_opts)
---- detect file type to change command
vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
    callback = function()
       if vim.bo.filetype == "cpp" then
           cmd = cpp .. ext .. " % && ." .. sep .. "main" .. ext
       elseif vim.bo.filetype == "c" then
           cmd = c .. ext .. " % && ." .. sep .. "main" .. ext
       elseif vim.bo.filetype == "python" then
           cmd = py .. " %"
       end
       keymap("n", "<leader>p", ":!" .. cmd .. "<CR>", default_opts)
    end,
})


-- <C-c> will raise interrupted error of lsp
keymap("i", "<C-C>", "<C-[>", default_opts)

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
keymap("n", "<expr> k", "(v:count > 5 ? 'm'' . v:count: '') . 'k'", expr_opts)
keymap("n", "<expr> j", "(v:count > 5 ? 'm'' . v:count: '') . 'j'", expr_opts)

vim.api.nvim_create_user_command('W', 'silent w', {})
vim.api.nvim_create_user_command('Wa', 'silent wa', {})
vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})

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

keymap("i", "<S-Tab>", "<C-d>", default_opts)
keymap("i", "<Tab>", "<C-i>", default_opts)

