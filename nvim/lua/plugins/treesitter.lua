return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  ft = { "sh", "c", "cpp", "lua", "markdown", "python", "txt", "go", "rust" },
  init = function(plugin)
    -- copy from folke
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treeitter** module to be loaded in time.
    -- Luckily, the only thins that those plugins need are the custom queries, which we make available
    -- during startup.
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },
  opts = {
    indent = {
      enable = false,
    },
    highlight = {
      enable = false,
    },
    incremental_selection = {
      enable = false,
    },
    -- bash, c, lua, markdown, markdown_inline, python, query, vim, vimdoc are all ported by default
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "vim",
      "vimdoc",
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
