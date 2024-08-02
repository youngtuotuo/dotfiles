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
          prompt = { " ", "│", "─", "│", "│", "│", "╯", "╰" },
          results = { "─", "│", "─", "│", "╭", "╮", "┤", "├" },
          preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
        preview = true,
      },
    })
    local builtin = require("telescope.builtin")
    vim.keymap.set({ "n" }, "<space>e", builtin.find_files, { noremap = true })
    vim.keymap.set({ "n" }, "<space>h", builtin.help_tags, { noremap = true })
    vim.keymap.set({ "n" }, "<space>b", builtin.buffers, { noremap = true })
    vim.keymap.set({ "n" }, "<space>g", builtin.live_grep, { noremap = true })
    vim.keymap.set({ "n" }, "<space>d", builtin.diagnostics, { noremap = true })
    vim.keymap.set({ "n" }, "<space>r", builtin.lsp_references, { noremap = true })
  end,
}
