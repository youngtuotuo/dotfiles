require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c", "cpp", "python", "lua", "markdown_inline"
  },
    -- "markdown",
    -- "bash",
    -- "c",
    -- "cpp",
    -- "lua",
    -- "toml",
    -- "yaml",
    -- "python",
    -- "vim",
    -- "rust",
    -- "go",
    -- "latex",
    -- "regex",
    -- "markdown_inline",
    -- "html",
  ignore_install = { "zig" },
  indent = { enable = true },
  auto_install = false,
  highlight = {
    enable = false, -- false will disable the whole extension
    disable = { "latex", "bash", "zig", "markdown" },
  },
  textobjects = {
    enable = true,
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
      goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
      goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
      goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
    },
  },
})
-- TreeSitter highlight toggle
vim.api.nvim_set_keymap("n", "<leader>h", ":TSToggle highlight<CR>", { noremap = true, silent = true })
