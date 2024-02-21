return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = { "BufRead" },
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
      config = function(_, _)
        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

        local keyms = {
          -- vim way: ; goes to the direction you were moving.
          { { "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move },
          { { "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite },

          -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
          { { "n", "x", "o" }, "f", ts_repeat_move.builtin_f },
          { { "n", "x", "o" }, "F", ts_repeat_move.builtin_F },
          { { "n", "x", "o" }, "t", ts_repeat_move.builtin_t },
          { { "n", "x", "o" }, "T", ts_repeat_move.builtin_T },
        }
        for _, v in ipairs(keyms) do
          vim.keymap.set(unpack(v))
        end
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = {
        max_lines = 3,
        trim_scope = "inner",
      }
    }
  },
  opts = {
    indent = {
      enable = true
    },
    highlight = {
      enable = true,
    },
    matchup = {
      enable = true,
      disable_virtual_text = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>", -- set to `false` to disable one of the mappings
        scope_incremental = false,
        node_incremental = "<TAB>",
        node_decremental = "<S-TAB>",
      },
    },
    ensure_installed = {
      "gitcommit",
      "gitignore",
      "go",
      "python",
      "c",
      -- will cause slow startup when opening .h files
      -- "cpp",
      "lua",
      "markdown",
      "markdown_inline",
      "query",
      "rust",
      "vim",
      "vimdoc",
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
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",
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
          ["]l"] = "@loop.outer",
          ["]i"] = "@conditional.outer",
          ["]s"] = "@scope.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
          ["]L"] = "@loop.outer",
          ["]I"] = "@conditional.outer",
          ["]S"] = "@scope.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
          ["[l"] = "@loop.outer",
          ["[i"] = "@conditional.outer",
          ["[s"] = "@scope.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
          ["[L"] = "@loop.outer",
          ["[I"] = "@conditional.outer",
          ["[S"] = "@scope.outer",
        },
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
