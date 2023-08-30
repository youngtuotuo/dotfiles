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

-- -- format
-- keymap("n", "<leader>f", function()
--   vim.lsp.buf.format()
-- end, default_opts)

keymap("n", "-", "<cmd>E<cr>", default_opts)
keymap("n", "<leader>t", function()
  local current_bufnr = vim.fn.bufnr()
  local terminal_bufnr = nil
  local buf = nil
  -- Iterate through the buffer list
  for _, b in ipairs(vim.fn.getbufinfo()) do
    local bufname = b.name
    -- Check if the buffer name starts with "term"
    if bufname and vim.startswith(bufname, "term") then
      terminal_bufnr = b.bufnr
      buf = b
      break
    end
  end
  if not terminal_bufnr then
    -- Open a new terminal buffer
    vim.cmd("13sp | terminal")
  else
    if buf.hidden == 1 then
      vim.cmd("13 sp | b" .. terminal_bufnr)
    end
  end
end, default_opts)

-- <C-c> will raise interrupted error of lsp
keymap("i", "<C-c>", "<C-[>", default_opts)

keymap("n", "<leader>l", "<Plug>NetrwRefresh", default_opts)

-- Not show native menu
keymap("i", "<C-n>", "<nop>", default_opts)
keymap("i", "<C-p>", "<nop>", default_opts)
keymap("n", "Q", "<nop>", default_opts)

-- Easier pane navigation
-- keymap("n", "<C-j>", "<C-w>j", default_opts)
-- keymap("n", "<C-h>", "<C-w>h", default_opts)
-- keymap("n", "<C-k>", "<C-w>k", default_opts)
-- keymap("n", "<C-l>", "<C-w>l", default_opts)

-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
-- esc to exit terminal mode
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
-- keymap("n", "n", "nzzzv", default_opts)
-- keymap("n", "N", "Nzzzv", default_opts)

-- keymap("n", "<C-d>", "<C-d>zz", default_opts)
-- keymap("n", "<C-u>", "<C-u>zz", default_opts)

-- Center search results
-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", [["_dP]], default_opts)

-- Move selected line / block of text in visual mode
keymap({ "v", "x" }, "J", ":move '>+1<CR>gv=gv", default_opts)
keymap({ "v", "x" }, "K", ":move '<-2<CR>gv=gv", default_opts)

-- Undo break points
keymap("i", ",", ",<C-g>u", default_opts)
keymap("i", ".", ".<C-g>u", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohl<CR>", default_opts)

-- Resizing panes
keymap("n", "<S-Left>", "<cmd>vertical resize -1<CR>", default_opts)
keymap("n", "<S-Right>", "<cmd>vertical resize +1<CR>", default_opts)
keymap("n", "<S-Up>", "<cmd>resize +1<CR>", default_opts)
keymap("n", "<S-Down>", "<cmd>resize -1<CR>", default_opts)

keymap("i", "<S-Tab>", "<C-d>", default_opts)
keymap("i", "<Tab>", "<C-i>", default_opts)

-- better search and replace
keymap("n", "<space>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap("n", "<space>x", "<cmd>!chmod +x %<cr>", default_opts)

-- better external command ouput
keymap("n", "<leader>x", [[:sp | terminal ]])
