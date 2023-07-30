require('nvim-treesitter.parsers').get_parser_configs().asm = {
    install_info = {
        url = 'https://github.com/rush-rs/tree-sitter-asm.git',
        files = { 'src/parser.c' },
        branch = 'main',
    },
}
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "asm",
    "markdown",
    "bash",
    "c",
    "cpp",
    "lua",
    "toml",
    "yaml",
    "python",
    "vim",
    "rust",
    "go",
    "latex",
    "regex",
    "markdown_inline",
    "html",
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  indent = { enable = true },
  auto_install = true,
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "latex", "bash" },
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
