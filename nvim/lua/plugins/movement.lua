return {
  {
    "tpope/vim-rsi",
    config = function()
      vim.cmd([[inoremap <expr> <C-E> "\<Lt>End>"]])
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    ft = { "sh", "c", "cpp", "cuda", "lua", "markdown", "python", "txt", "go", "rust" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
          "lewis6991/gitsigns.nvim",
        },
        config = function()
          local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

          -- Repeat movement with ; and ,
          -- ensure ; goes forward and , goes backward regardless of the last direction
          vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
          vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

          -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
          vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
          vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
          vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
          vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

          local ok, gs = pcall(require, "gitsigns")
          if ok then
            -- example: make gitsigns.nvim movement repeatable with ; and , keys.
            local gs = require("gitsigns")

            -- make sure forward function comes first
            local next_hunk_repeat, prev_hunk_repeat =
              ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
            -- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.
            vim.keymap.set({ "n", "x", "o" }, "]c", next_hunk_repeat)
            vim.keymap.set({ "n", "x", "o" }, "[c", prev_hunk_repeat)
          end
        end,
      },
    },
    opts = {
      indent = {
        enable = false,
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
        "zig",
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
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
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
            ["]i"] = "@conditional.outer",
            ["]l"] = "@loop.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
            ["]I"] = "@conditional.outer",
            ["]L"] = "@loop.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
            ["[i"] = "@conditional.outer",
            ["[l"] = "@loop.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
            ["[I"] = "@conditional.outer",
            ["[L"] = "@loop.outer",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    opts = { useDefaultKeymaps = false },
    config = function(_, opts)
      require("various-textobjs").setup(opts)
      vim.keymap.set({ "o", "x" }, "as", '<cmd>lua require("various-textobjs").subword("outer")<CR>')
      vim.keymap.set({ "o", "x" }, "is", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    cond = function()
      return vim.o.filetype ~= "TelescopPrompt" and vim.o.filetype ~= "help"
    end,
    ft = { "typst", "python", "html" },
    version = "v2.*",
    opts = {
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
    },
    config = function(_, opts)
      local ls = require("luasnip")
      local snippet_path = vim.fn.stdpath("config") .. "/lua/snippets/"
      require("luasnip.loaders.from_lua").load({ paths = snippet_path })
      vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])
      ls.config.set_config(opts)
      local next_node = function()
        if require("luasnip").jumpable(1) then
          require("luasnip").jump(1)
        end
      end
      local prev_node = function()
        if require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        end
      end
      local cycle_choice = function()
        if require("luasnip").choice_active() then
          require("luasnip").change_choice(1)
        end
      end
      vim.keymap.set({ "i", "s" }, "<C-n>", next_node, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-p>", prev_node, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-j>", cycle_choice, { silent = true })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set("n", "<leader>h", function()
        harpoon:list():add()
      end)
      vim.keymap.set("n", "<leader>q", function()
        harpoon.ui:toggle_quick_menu(harpoon:list(), {
          border = "",
        })
      end)

      vim.keymap.set("n", "<leader>1", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<leader>2", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<leader>3", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<leader>4", function()
        harpoon:list():select(4)
      end)
      harpoon:extend({
        UI_CREATE = function(cx)
          vim.keymap.set("n", "<C-v>", function()
            harpoon.ui:select_menu_item({ vsplit = true })
          end, { buffer = cx.bufnr })

          vim.keymap.set("n", "<C-s>", function()
            harpoon.ui:select_menu_item({ split = true })
          end, { buffer = cx.bufnr })
        end,
      })
    end,
  },
}
