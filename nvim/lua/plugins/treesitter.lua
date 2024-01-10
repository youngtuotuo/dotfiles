return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufRead",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        config = function()
          require("nvim-treesitter.configs").setup({
            highlight = {
              enable = false
            },
            ensure_installed = {
              "gitcommit",
              "gitignore",
              "python",
              "c",
              "cpp",
              "lua",
              "markdown",
              "markdown_inline",
              "query",
              "vim",
              "vimdoc",
            },
            textobjects = {
              select = {
                enable = true,

                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,

                keymaps = {
                  -- You can use the capture groups defined in textobjects.scm
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["ac"] = "@class.outer",
                  -- You can optionally set descriptions to the mappings (used in the desc parameter of
                  -- nvim_buf_set_keymap) which plugins like which-key display
                  ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                  -- You can also use captures from other query groups like `locals.scm`
                  ["as"] = {
                    query = "@scope",
                    query_group = "locals",
                    desc = "Select language scope",
                  },
                },
                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                selection_modes = {
                  ["@parameter.outer"] = "v", -- charwise
                  ["@function.outer"] = "V", -- linewise
                  ["@class.outer"] = "<c-v>", -- blockwise
                },
                -- If you set this to `true` (default is `false`) then any textobject is
                -- extended to include preceding or succeeding whitespace. Succeeding
                -- whitespace has priority in order to act similarly to eg the built-in
                -- `ap`.
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * selection_mode: eg 'v'
                -- and should return true of false
                include_surrounding_whitespace = true,
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
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                  ["]m"] = "@function.outer",
                  ["]]"] = { query = "@class.outer", desc = "Next class start" },
                  -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                  ["]o"] = "@loop.*",
                  -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                  -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                  ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                  ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                },
                goto_next_end = {
                  ["]M"] = "@function.outer",
                  ["]["] = "@class.outer",
                },
                goto_previous_start = {
                  ["[m"] = "@function.outer",
                  ["[["] = "@class.outer",
                  -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                  ["[o"] = "@loop.*",
                  -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                  -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                  ["[s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                  ["[z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                },
                goto_previous_end = {
                  ["[M"] = "@function.outer",
                  ["[]"] = "@class.outer",
                },
              },
            },
          })
          vim.cmd([[TSUpdate]])
        end,
      },
      { "lewis6991/gitsigns.nvim" },
    },
    config = function()
      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

      -- vim way: ; goes to the direction you were moving.
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

      -- example: make gitsigns.nvim movement repeatable with ; and , keys.
      local gs_status, gs = pcall(require, "gitsigns")

      -- make sure forward function comes first
      if gs_status then
        local next_hunk_repeat, prev_hunk_repeat =
          ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
        -- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.

        vim.keymap.set({ "n", "x", "o" }, "]c", next_hunk_repeat)
        vim.keymap.set({ "n", "x", "o" }, "[c", prev_hunk_repeat)
      end
    end,
  },
}
