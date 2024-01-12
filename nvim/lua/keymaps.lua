-- stylua: ignore start
--  CHAR	MODE
-- <Space>      Normal, Visual, Select and Operator-pending
-- n            Normal
-- v            Visual and Select
-- s            Select
-- x            Visual
-- o            Operator-pending
-- !            Insert and Command-line
-- i            Insert
-- l            ":lmap" mappings for Insert, Command-line and Lang-Arg
-- c            Command-line
-- t            Terminal-Job

vim.keymap.set({ "i" }, "<C-c>", "<C-[>",       { noremap = true, desc = "Esc, C-c will raise inetrrutped error" })
vim.keymap.set({ "t" }, "<C-[>", "<C-\\><C-n>", { noremap = true, desc = "Term mode to normal mode with Esc" })

vim.keymap.set({ "i" }, "<C-n>", "<nop>", { noremap = true, desc = "Not show native menu" })
vim.keymap.set({ "i" }, "<C-p>", "<nop>", { noremap = true, desc = "Not show native menu" })
vim.keymap.set({ "n" }, "Q",     "<nop>", { noremap = true, desc = "Q repeat the last recorded register [count] times, no need" })
vim.keymap.set({ "n" }, "<C-q>", "<nop>", { noremap = true, desc = "Never use C-q to enter visual block mode" })

vim.keymap.set({ "n" }, "<leader>s", "<cmd>set invnu invrnu<cr>", { noremap = true, desc = "<cmd>set invnu invrnu<cr>, Toggle nu and rnu" })

vim.keymap.set({ "n" }, "Y", "y$", { noremap = true, desc = "y$, Y like C, D" })

vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y', { noremap = true, desc = "y, but yank to system clipboard" })
vim.keymap.set({ "n" },           "<leader>Y", '"+y$', { noremap = true, desc = "y$, but yank to system clipboard" })

vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"_d', { noremap = true, desc = "d, but not go to register" })

vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true, desc = "J, but will keep your cursor position" })

vim.keymap.set({ "n" }, "n", "nzz", { noremap = true, desc = "n, with cursor keep in middle" })
vim.keymap.set({ "n" }, "N", "Nzz", { noremap = true, desc = "N, with cursor keep in middle" })

vim.keymap.set({ "v", "x" }, "p", [["_dP]],   { noremap = true, desc = "[[\"_dP]], Paste over currently selected text without yanking it" })
vim.keymap.set({ "n", "v", "x" }, "p", "p'.V']=", { noremap = true, desc = "p'[v']<esc>==, Paste with indent" })
vim.keymap.set({ "n", "v", "x" }, "P", "P'.V']=", { noremap = true, desc = "P'[v']<esc>==, Paste with indent" })

vim.keymap.set({ "v", "x" }, "J", ":move '>+1<CR>gv=gv", { noremap = true, desc = ":move '>+1<CR>gv=gv, Move selected line / block of text down" })
vim.keymap.set({ "v", "x" }, "K", ":move '<-2<CR>gv=gv", { noremap = true, desc = ":move '<-2<CR>gv=gv, Move selected line / block of text up" })
vim.keymap.set({ "v", "x" }, "H", "<gv", { noremap = true, desc = "<gv, Move selected line / block of text left" })
vim.keymap.set({ "v", "x" }, "L", ">gv", { noremap = true, desc = ">gv, Move selected line / block of text right" })
vim.keymap.set({ "v", "x" }, "<", "<gv", { noremap = true, desc = "<gv, Move selected line / block of text left" })
vim.keymap.set({ "v", "x" }, ">", ">gv", { noremap = true, desc = ">gv, Move selected line / block of text right" })

vim.keymap.set({ "i" }, ",", ",<C-g>u", { noremap = true, desc = "let , be undo break points" })
vim.keymap.set({ "i" }, ".", ".<C-g>u", { noremap = true, desc = "let . be undo break points" })

vim.keymap.set({ "n" }, "<S-Right>", "<cmd>vertical resize +1<CR>", { noremap = true, desc = "vertical add pane 1 size" })
vim.keymap.set({ "n" }, "<S-Left>",  "<cmd>vertical resize -1<CR>", { noremap = true, desc = "vertical reduce pane 1 size" })

-- More indents options
vim.keymap.set({ "i" }, "<S-Tab>", "<C-d>", { noremap = true, desc = "let Shift-Tab go back one indent" })

-- better search and replace
if vim.fn.has("win32") == 1 then
  vim.keymap.set({ "n" }, "<space>x", "<cmd>!chmod +x %<cr>", { noremap = true, desc = "add x to current file permission" })
end

-- better external command ouput
vim.keymap.set({ "n" }, "<leader>x", [[:sp | terminal<C-b>]], { noremap = true, desc = ":sp | terminal , execute external command with output to pane" })

-- more intuitive command mode keys
vim.opt.wildcharm = vim.fn.char2nr('^I')
vim.keymap.set({ "c" }, "<up>",    function() if vim.fn.wildmenumode() == 1 then return "<left>"         else return "<up>"    end end, { noremap = true, expr = true })
vim.keymap.set({ "c" }, "<down>",  function() if vim.fn.wildmenumode() == 1 then return "<right>"        else return "<down>"  end end, { noremap = true, expr = true })
vim.keymap.set({ "c" }, "<left>",  function() if vim.fn.wildmenumode() == 1 then return "<up>"           else return "<left>"  end end, { noremap = true, expr = true })
vim.keymap.set({ "c" }, "<right>", function() if vim.fn.wildmenumode() == 1 then return "<bs><c-z><c-z>" else return "<right>" end end, { noremap = true, expr = true })
