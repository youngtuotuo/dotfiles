-- Shorten function name
local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Modes
-- normal_mode = "n"
-- insert_mode = "i"
-- visual_mode = "v"
-- visual_block_mode = "x"
-- command_mode = "c"
-- term_mode = "t"

-- <C-c> will raise interrupted error of lsp
keymap("i", "<C-c>", "<C-[>", default_opts)

keymap("n", "<leader>l", "<Plug>NetrwRefresh", default_opts)

-- Not show native menu
keymap("i", "<C-n>", "<nop>", default_opts)
keymap("i", "<C-p>", "<nop>", default_opts)
keymap("n", "Q", "<nop>", default_opts)

keymap("t", "<Esc>", "<C-\\><C-n>", term_opts)

-- number line
keymap("n", "<leader>s", ":set invnu invrnu<CR>", default_opts)

-- Y like C,D
keymap("n", "Y", "y$", default_opts)

-- system clipboard yank
keymap({ "n", "v" }, "<leader>y", '"+y', default_opts)
keymap("n", "<leader>Y", '"+Y', default_opts)

-- delete avoid register
keymap({ "n", "v" }, "<leader>d", '"_d', default_opts)
keymap("n", "J", "mzJ`z", default_opts)

-- search item center
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", [["_dP]], default_opts)

-- Move selected line / block of text in visual mode
keymap({ "v", "x" }, "J", ":move '>+1<CR>gv=gv", default_opts)
keymap({ "v", "x" }, "K", ":move '<-2<CR>gv=gv", default_opts)
keymap({ "v", "x" }, "H", "<gv", default_opts)
keymap({ "v", "x" }, "L", ">gv", default_opts)

-- Undo break points
keymap("i", ",", ",<C-g>u", default_opts)
keymap("i", ".", ".<C-g>u", default_opts)

-- Resizing panes
keymap("n", "<S-Left>", "<cmd>vertical resize -1<CR>", default_opts)
keymap("n", "<S-Right>", "<cmd>vertical resize +1<CR>", default_opts)
keymap("n", "<S-Up>", "<cmd>resize +1<CR>", default_opts)
keymap("n", "<S-Down>", "<cmd>resize -1<CR>", default_opts)

-- More indents options
keymap("i", "<S-Tab>", "<C-d>", default_opts)
keymap("i", "<Tab>", "<C-i>", default_opts)

-- better search and replace
keymap("n", "<space>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap("n", "<space>x", "<cmd>!chmod +x %<cr>", default_opts)

-- better external command ouput
keymap("n", "<leader>x", [[:sp | terminal ]])

vim.cmd [[
  set wildcharm=<Tab>
  cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
  cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
  cnoremap <expr> <left> wildmenumode() ? "\<up>" : "\<left>"
  cnoremap <expr> <c-j> wildmenumode() ? "\<up>" : "\<c-j>"
  cnoremap <expr> <right> wildmenumode() ? " \<bs>\<C-Z>" : "\<right>"
  cnoremap <expr> <c-k> wildmenumode() ? " \<bs>\<C-Z>" : "\<c-k>"
  cnoremap <c-n> <Tab>
]]
