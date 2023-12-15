local g = require("tuo.global")
require("lspsaga").setup({
  preview = { lines_above = 0, lines_below = 10 },
  scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
  request_timeout = 2000,
  beacon = { enable = true, frequency = 20 },
  outline = {
    win_position = "left",
    win_width = 30,
    preview_width = 0.1,
    auto_preview = false,
    detail = true,
    auto_close = true,
    close_after_jump = false,
    layout = "normal",
    max_height = 0.8,
    left_width = 0.3,
    keys = {
      toggle_or_jump = "o",
      quit = "q",
      jump = "e",
    },
  },
  callhierarchy = {
    keys = {
      edit = "e",
      vsplit = "s",
      split = "i",
      tabe = "t",
      quit = "q",
      shuttle = "[w",
      toggle_or_req = "u",
      close = "<C-c>k",
    },
    layout = "float",
  },
  lightbulb = {
    enable = false,
  },
  symbol_in_winbar = {
    enable = false,
    separator = " › ",
    hide_keyword = true,
    show_file = true,
    folder_level = 1,
    color_mode = true,
  },
  code_action = {
    num_shortcut = true,
    show_server_name = true,
    extend_gitsigns = false,
  }
})
vim.keymap.set("n", "ga",       ":Lspsaga code_action<cr>", { noremap = true })
vim.keymap.set("n", "gn",       ":Lspsaga rename<cr>", { noremap = true })
vim.keymap.set("n", "gic",      ":Lspsaga incoming_calls<cr>", { noremap = true })
vim.keymap.set("n", "goc",      ":Lspsaga outgoing_calls<cr>", { noremap = true })
vim.keymap.set("n", "<space>o", ":Lspsaga outline<cr>", { noremap = true })
