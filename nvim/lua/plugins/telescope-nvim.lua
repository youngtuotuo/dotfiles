return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        layout_strategy = "vertical",
        mappings = {
          i = {
            ["<C-s>"] = require("telescope.actions").select_horizontal,
            ["<C-x>"] = false,
          },
          n = {
            ["<C-s>"] = require("telescope.actions").select_horizontal,
            ["<C-x>"] = false,
          },
        },
        borderchars = {
          prompt  = { " ", "│", "─", "│", "│", "│", "╯", "╰" },
          results = { "─", "│", "─", "│", "╭", "╮", "┤", "├" },
          preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
        preview = true,
      },
    })
    local builtin = require("telescope.builtin")
    vim.keymap.set({ "n" }, "<space>e", "<cmd>Telescope find_files disable_devicons=true<cr>",     { noremap = true })
    vim.keymap.set({ "n" }, "<space>h", "<cmd>Telescope help_tags<cr>",      { noremap = true })
    vim.keymap.set({ "n" }, "<space>b", "<cmd>Telescope buffers disable_devicons=true<cr>",        { noremap = true })
    vim.keymap.set({ "n" }, "<space>g", "<cmd>Telescope live_grep disable_devicons=true<cr>",      { noremap = true })
    vim.keymap.set({ "n" }, "<space>d", "<cmd>Telescope diagnostics disable_devicons=true<cr>",    { noremap = true })
    vim.keymap.set({ "n" }, "<space>r", "<cmd>Telescope lsp_references disable_devicons=true<cr>", { noremap = true })
  end,
}
