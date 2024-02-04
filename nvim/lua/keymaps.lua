--  CHAR	    MODE
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

-- stylua: ignore
local keyms = {
  { { "i" }, "<C-n>", "<nop>", { noremap = true, desc = "Not show native menu" } },
  { { "i" }, "<C-p>", "<nop>", { noremap = true, desc = "Not show native menu" } },
  { { "i" }, "<C-c>", "<nop>", { noremap = true, desc = "Disable interrupt" } },

  { { "n", "v" }, "q:", "<nop>", { noremap = true, desc = "Bad doggy" } },
  { { "n", "v" }, "q/", "<nop>", { noremap = true, desc = "Bad doggy" } },
  { { "n", "v" }, "q?", "<nop>", { noremap = true, desc = "Bad doggy" } },

  { { "n" }, "Q",     "<nop>", { noremap = true, desc = "Q repeat the last recorded register [count] times, no need" } },
  { { "n" }, "<C-q>", "<nop>", { noremap = true, desc = "Never use C-q to enter visual block mode" } },

  { { "i" }, ",",     ",<C-g>u", { noremap = true, desc = "let , be undo break points" } },
  { { "i" }, ".",     ".<C-g>u", { noremap = true, desc = "let . be undo break points" } },
  { { "i" }, "<C-c>", "<C-[>",   { noremap = true, desc = "Esc, C-c will raise inetrrutped error" } },

  -- More indents options
  { { "i" }, "<S-Tab>", "<C-d>", { noremap = true, desc = "let Shift-Tab go back one indent" } },

  { { "t" }, "<C-[>", "<C-\\><C-n>", { noremap = true, desc = "Term mode to normal mode with Esc" } },

  { { "n" }, "<leader>s", "<cmd>set invnu invrnu<cr>", { noremap = true, desc = "<cmd>set invnu invrnu<cr>, Toggle nu and rnu" } },

  { { "n" }, "Y", "y$", { noremap = true, desc = "y$, Y like C, D" } },

  { { "n" }, "<S-Right>", "<cmd>vertical resize +1<CR>", { noremap = true, desc = "vertical add pane 1 size" } },
  { { "n" }, "<S-Left>", "<cmd>vertical resize -1<CR>", { noremap = true, desc = "vertical reduce pane 1 size" } },
  { { "n" }, "<S-Up>", "<cmd>resize +1<CR>", { noremap = true, desc = "vertical add pane 1 size" } },
  { { "n" }, "<S-Down>", "<cmd>resize -1<CR>", { noremap = true, desc = "vertical reduce pane 1 size" } },

  -- better external command ouput
  { { "n" }, "<space>x", [[:terminal <C-b>]], { noremap = true, desc = ":terminal , execute external command with output to pane" } },

  { { "n", "v" }, "<leader>y", '"+y', { noremap = true, desc = "y, but yank to system clipboard" } },

  { { "n" }, "J", "mzJ`z", { noremap = true, desc = "J, but will keep your cursor position" } },

  { { "v" }, "p", [["_dP]], { noremap = true, desc = [["_dP, Paste over currently selected text without yanking it]] } },

  { { "v" }, "J", ":move '>+1<CR>gv=gv", { noremap = true, desc = ":move '>+1<CR>gv=gv, Move selected line / block of text down" } },
  { { "v" }, "K", ":move '<-2<CR>gv=gv", { noremap = true, desc = ":move '<-2<CR>gv=gv, Move selected line / block of text up" } },
  { { "v" }, "H", "<gv", { noremap = true, desc = "<gv, Move selected line / block of text left" } },
  { { "v" }, "L", ">gv", { noremap = true, desc = ">gv, Move selected line / block of text right" } },
  { { "v" }, "<", "<gv", { noremap = true, desc = "<gv, Move selected line / block of text left" } },
  { { "v" }, ">", ">gv", { noremap = true, desc = ">gv, Move selected line / block of text right" } },

  -- more intuitive command mode keys
  { { "c" }, "<up>", function()
      if vim.fn.wildmenumode() == 1 then
        return "<left>"
      else
        return "<up>"
      end
    end, { noremap = true, expr = true },
  },
  { { "c" }, "<down>", function()
      if vim.fn.wildmenumode() == 1 then
        return "<right>"
      else
        return "<down>"
      end
    end, { noremap = true, expr = true },
  },
  { { "c" }, "<left>", function()
      if vim.fn.wildmenumode() == 1 then
        return "<up>"
      else
        return "<left>"
      end
    end, { noremap = true, expr = true },
  },
  { { "c" }, "<right>", function()
      if vim.fn.wildmenumode() == 1 then
        return "<bs><c-z><c-z>"
      else
        return "<right>"
      end
    end, { noremap = true, expr = true },
  },
  { { "c" }, "<c-a>", "<c-b>", { noremap = true } },
}

if vim.fn.has("win32") == 0 then
  table.insert(keyms, { { "n" }, "<leader>x", "<cmd>!chmod +x %<cr>", { noremap = true, desc = "add x to current file permission" } })
end

for _, v in ipairs(keyms) do
  vim.keymap.set(unpack(v))
end
