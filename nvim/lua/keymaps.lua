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
vim.keymap.set({ "n" }, "Q", "<nop>", {
  nowait = true,
  noremap = true,
  desc = "Q repeat the last recorded register [count] times, no need",
})
vim.keymap.set(
  { "n" },
  "<C-q>",
  "<nop>",
  { nowait = true, noremap = true, desc = "Never use C-q to enter visual block mode" }
)

vim.keymap.set(
  { "n" },
  "<space>e",
  ":find ",
  { nowait = true, noremap = true }
)

vim.keymap.set(
  { "n" },
  "<space>g",
  ":vim // **<left><left><left><left>",
  { nowait = true, noremap = true }
)

vim.keymap.set(
  { "n" },
  "<space>l",
  ":lvim // %<left><left><left>",
  { nowait = true, noremap = true }
)

vim.keymap.set(
  { "n" },
  "<space>mp",
  ":lua vim.opt_local.makeprg=[[",
  { nowait = true, noremap = true }
)

vim.keymap.set({ "n" }, "d_", "d^", { nowait = true, noremap = true, desc = "Delete back to the first character" })
vim.keymap.set(
  { "n" },
  "c_",
  "c^",
  { nowait = true, noremap = true, desc = "Delete back to the first character and insert" }
)

vim.keymap.set(
  { "n" },
  "[q",
  "<cmd>cprev<cr>",
  { nowait = true, noremap = true, desc = "cprev" }
)
vim.keymap.set(
  { "n" },
  "]q",
  "<cmd>cnext<cr>",
  { nowait = true, noremap = true, desc = "cnext" }
)
vim.keymap.set(
  { "n" },
  "<leader>c",
  function()
    local windows = vim.fn.getwininfo()
    for _, win in pairs(windows) do
      if win["quickfix"] == 1 and win["loclist"] == 0 then
        vim.cmd.cclose()
        return
      end
    end
    vim.cmd.copen()
  end,
  { nowait = true, noremap = true, desc = "toggle quickfix window" }
)
vim.keymap.set(
  { "n" },
  "[l",
  "<cmd>lprev<cr>",
  { nowait = true, noremap = true, desc = "lprev" }
)
vim.keymap.set(
  { "n" },
  "]l",
  "<cmd>lnext<cr>",
  { nowait = true, noremap = true, desc = "lnext" }
)
vim.keymap.set(
  { "n" },
  "<leader>o",
  function()
    local windows = vim.fn.getwininfo()
    for _, win in pairs(windows) do
      if win["quickfix"] == 1 and win["loclist"] == 1 then
        vim.cmd.lclose()
        return
      end
    end
    vim.cmd.lopen()
  end,
  { nowait = true, noremap = true, desc = "lnext" }
)

vim.keymap.set({ "i" }, ",", ",<C-g>u", { noremap = true, desc = "let , be undo break points" })
vim.keymap.set({ "i" }, ".", ".<C-g>u", { noremap = true, desc = "let . be undo break points" })

vim.keymap.set({ "n", "i" }, "<C-c>", "<esc>", { noremap = true, desc = "Esc, C-c will raise inetrrutped error" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true, desc = "y, but yank to system clipboard" })

-- More indents options
vim.keymap.set({ "i" }, "<S-Tab>", "<C-d>", { noremap = true, desc = "let Shift-Tab go back one indent" })

vim.keymap.set({ "t" }, "<C-[>", "<C-\\><C-n>", { noremap = true, desc = "Term mode to normal mode with Esc" })

vim.keymap.set(
  { "n" },
  "<leader>s",
  "<cmd>set invnu invrnu<cr>",
  { noremap = true, desc = "<cmd>set invnu invrnu<cr>, Toggle nu and rnu" }
)

vim.keymap.set({ "n" }, "Y", "y$", { noremap = true, desc = "y$, Y like C, D" })

vim.keymap.set(
  { "n" },
  "<S-Right>",
  "<cmd>vertical resize +1<CR>",
  { noremap = true, desc = "vertical add pane 1 size" }
)
vim.keymap.set(
  { "n" },
  "<S-Left>",
  "<cmd>vertical resize -1<CR>",
  { noremap = true, desc = "vertical reduce pane 1 size" }
)
vim.keymap.set({ "n" }, "<S-Up>", "<cmd>resize +1<CR>", { noremap = true, desc = "vertical add pane 1 size" })
vim.keymap.set({ "n" }, "<S-Down>", "<cmd>resize -1<CR>", { noremap = true, desc = "vertical reduce pane 1 size" })

vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true, desc = "J, but will keep your cursor position" })

vim.keymap.set(
  { "v" },
  "p",
  [["_dP]],
  { noremap = true, desc = [["_dP, Paste over currently selected text without yanking it]] }
)
vim.keymap.set(
  { "n" },
  "<C-j>",
  "<cmd>move+1<cr>",
  { noremap = true, desc = ":move '>+1<CR>gv=gv, Move selected line / block of text down" }
)
vim.keymap.set(
  { "v" },
  "J",
  ":move '>+1<CR>gv=gv",
  { noremap = true, desc = ":move '>+1<CR>gv=gv, Move selected line / block of text down" }
)
vim.keymap.set(
  { "n" },
  "<C-k>",
  "<cmd>move--1<cr>",
  { noremap = true, desc = ":move '<-2<CR>gv=gv, Move selected line / block of text up" }
)
vim.keymap.set(
  { "v" },
  "K",
  ":move '<-2<CR>gv=gv",
  { noremap = true, desc = ":move '<-2<CR>gv=gv, Move selected line / block of text up" }
)
vim.keymap.set({ "v" }, "<", "<gv", { noremap = true, desc = "<gv, Move selected line / block of text left" })
vim.keymap.set({ "v" }, ">", ">gv", { noremap = true, desc = ">gv, Move selected line / block of text right" })
