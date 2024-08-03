-- stylua: ignore start
--  CHAR        MODE
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

vim.keymap.set({ "i" }, "<C-p>", "<nop>", { nowait = true, noremap = true, desc = "Not show native menu" })
vim.keymap.set({ "i" }, "<C-n>", "<nop>", { nowait = true, noremap = true, desc = "Not show native menu" })
vim.keymap.set({ "i" }, "<C-c>", "<nop>", { nowait = true, noremap = true, desc = "Disable interrupt" })
vim.keymap.set({ "n" }, "Q",     "<nop>", { nowait = true, noremap = true, desc = "Q repeat the last recorded register [count] times, no need", })
vim.keymap.set({ "n" }, "<C-q>", "<nop>", { nowait = true, noremap = true, desc = "Never use C-q to enter visual block mode" })
vim.keymap.set({ "n" }, "d_",    "d^",    { nowait = true, noremap = true, desc = "Delete back to the first character" })
vim.keymap.set({ "n" }, "c_",    "c^",    { nowait = true, noremap = true, desc = "Delete back to the first character and insert" })

vim.keymap.set({ "i" }, ",",     ",<C-g>u", { noremap = true, desc = "let , be undo break points" })
vim.keymap.set({ "i" }, ".",     ".<C-g>u", { noremap = true, desc = "let . be undo break points" })

vim.keymap.set({ "i" }, "<C-s>", "<C-A>",      { noremap = true, desc = "Try" })
vim.keymap.set({ "c" }, "<C-i>", "<C-l><C-d>", { noremap = true, desc = "I hate menu" })

vim.keymap.set({ "n", "i" }, "<C-c>",     "<esc><cmd>noh<cr>", { noremap = true, desc = "Esc, C-c will raise inetrrutped error" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y',               { noremap = true, desc = "y, but yank to system clipboard" })

-- More indents options
vim.keymap.set({ "i" }, "<S-Tab>",   "<C-d>",                     { noremap = true, desc = "let Shift-Tab go back one indent" })
vim.keymap.set({ "t" }, "<C-[>",     "<C-\\><C-n>",               { noremap = true, desc = "Term mode to normal mode with Esc" })
vim.keymap.set({ "n" }, "<leader>s", "<cmd>set invnu invrnu<cr>", { noremap = true, desc = "<cmd>set invnu invrnu<cr>, Toggle nu and rnu" })
vim.keymap.set({ "n" }, "Y",         "y$",                        { noremap = true, desc = "y$, Y like C, D" })
vim.keymap.set({ "n" }, "J",         "mzJ`z",                     { noremap = true, desc = "J, but will keep your cursor position" })

vim.keymap.set({ "v" }, "p",     [["_dP]],              { noremap = true, desc = [["_dP, Paste over currently selected text without yanking it]] })
vim.keymap.set({ "n" }, "<M-j>", "<cmd>move+1<cr>",     { noremap = true, desc = ":move '>+1<CR>gv=gv, Move selected line / block of text down" })
vim.keymap.set({ "v" }, "J",     ":move '>+1<CR>gv=gv", { noremap = true, desc = ":move '>+1<CR>gv=gv, Move selected line / block of text down" })
vim.keymap.set({ "n" }, "<M-k>", "<cmd>move--1<cr>",    { noremap = true, desc = ":move '<-2<CR>gv=gv, Move selected line / block of text up" })
vim.keymap.set({ "v" }, "K",     ":move '<-2<CR>gv=gv", { noremap = true, desc = ":move '<-2<CR>gv=gv, Move selected line / block of text up" })
vim.keymap.set({ "v" }, "<",     "<gv",                 { noremap = true, desc = "<gv, Move selected line / block of text left" })
vim.keymap.set({ "v" }, ">",     ">gv",                 { noremap = true, desc = ">gv, Move selected line / block of text right" })

vim.keymap.set({ "n" }, "]p", function() vim.cmd([[try | cnext | catch | cfirst | catch | endtry]]) end, { nowait = true, noremap = true, desc = "cnext" })
vim.keymap.set({ "n" }, "[p", function() vim.cmd([[try | cprev | catch | clast  | catch | endtry]]) end, { nowait = true, noremap = true, desc = "cprev" })
vim.keymap.set({ "n" }, "<leader>p", function()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win["quickfix"] == 1 and win["loclist"] == 0 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end, { nowait = true, noremap = true, desc = "toggle quickfix window" })

vim.keymap.set({ "n" }, "]l", function() vim.cmd([[try | lnext | catch | lfirst | catch | endtry]]) end, { nowait = true, noremap = true, desc = "lnext" })
vim.keymap.set({ "n" }, "[l", function() vim.cmd([[try | lprev | catch | llast  | catch | endtry]]) end, { nowait = true, noremap = true, desc = "lprev" })
vim.keymap.set({ "n" }, "<leader>l", function()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win["quickfix"] == 1 and win["loclist"] == 1 then
      vim.cmd.lclose()
      return
    end
  end
  vim.cmd.lopen()
end, { nowait = true, noremap = true, desc = "toggle location list" })

vim.api.nvim_create_user_command("W",   "w",   { bang = true, bar = true })
vim.api.nvim_create_user_command("Q",   "q",   { bang = true, bar = true })
vim.api.nvim_create_user_command("X",   "x",   { bang = true, bar = true })
vim.api.nvim_create_user_command("WQ",  "wq",  { bang = true, bar = true })
vim.api.nvim_create_user_command("Wq",  "wq",  { bang = true, bar = true })
vim.api.nvim_create_user_command("WA",  "wa",  { bang = true, bar = true })
vim.api.nvim_create_user_command("Wa",  "wa",  { bang = true, bar = true })
vim.api.nvim_create_user_command("QA",  "qa",  { bang = true, bar = true })
vim.api.nvim_create_user_command("Qa",  "qa",  { bang = true, bar = true })
vim.api.nvim_create_user_command("WQA", "wqa", { bang = true, bar = true })
vim.api.nvim_create_user_command("WQa", "wqa", { bang = true, bar = true })
vim.api.nvim_create_user_command("Wqa", "wqa", { bang = true, bar = true })
vim.api.nvim_create_user_command("XA",  "xa",  { bang = true, bar = true })
vim.api.nvim_create_user_command("Xa",  "xa",  { bang = true, bar = true })
