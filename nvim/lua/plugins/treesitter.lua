return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  ft = { "sh", "c", "cpp", "cuda", "lua", "markdown", "python", "txt", "go", "rust" },
  dependencies = {
    -- { "nvim-treesitter/nvim-treesitter-context" },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },
  opts = {
    indent = {
      enable = true,
    },
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = false,
    },
    -- bash, c, lua, markdown, markdown_inline, python, query, vim, vimdoc are all ported by default
    ensure_installed = {
      -- "bash",
      -- "c",
      "cpp",
      "cuda",
      -- "lua",
      -- "markdown",
      -- "markdown_inline",
      -- "python",
      -- "query",
      -- "vim",
      -- "vimdoc",
      "html",
      "gitcommit",
      "gitignore",
      "go",
      "rust",
    },
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
        include_surrounding_whitespace = false,
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
  },
    },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
