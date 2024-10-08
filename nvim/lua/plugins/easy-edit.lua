return {
  {
    "tpope/vim-vinegar",
  },
  {
    "L3MON4D3/LuaSnip",
    cond = function()
      return vim.o.filetype ~= "TelescopPrompt" and vim.o.filetype ~= "help"
    end,
    ft = { "typst", "python" },
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
      vim.keymap.set({ "i", "s" }, "<C-j>", next_node, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-k>", prev_node, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-h>", cycle_choice, { silent = true })
    end,
  },
  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set({ "x" }, "ga", "<Plug>(EasyAlign)")
      vim.keymap.set({ "n" }, "ga", "<Plug>(EasyAlign)")
    end,
  },
  {
    "stevearc/stickybuf.nvim",
    opts = {},
  },
  {
    "chrisgrieser/nvim-spider",
    opts = {
      skipInsignificantPunctuation = false,
    },
    config = function(_, opts)
      require("spider").setup(opts)
      vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
      vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
      vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    ft = { "yaml", "json", "python", "sh", "lua", "c", "cpp", "cuda" },
    dependencies = {
      {
        "williamboman/mason.nvim",
      },
    },
    opts = {
      async = true,
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        sh = { "shfmt" },
        json = { "jq" },
        yaml = { "prettier" },
        html = { "prettier" },
      },
      formatters = {
        stylua = {
          prepend_args = {
            "--indent-type=spaces",
            "--indent-width=2",
            "--column-width=120",
          },
        },
        ruff_fmt = {
          prepend_args = {
            "--line-length=150",
            "--target-version=py311",
          },
        },
        clang_format = {
          prepend_args = {
            "-style={BasedOnStyle: llvm, IndentWidth: 4, AllowShortBlocksOnASingleLine: true, AllowShortIfStatementsOnASingleLine: true, BreakBeforeBraces: Custom, BraceWrapping: {AfterClass: true, AfterControlStatement: true, AfterEnum: true, AfterFunction: true, AfterNamespace: false, AfterStruct: true, AfterUnion: true, BeforeCatch: true, BeforeElse: true}}",
          },
        },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
      vim.keymap.set({ "n", "v" }, "<leader>f", require("conform").format, { noremap = true, desc = "Format buffer" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      enable_autocmd = false,
    },
    config = function(_, opts)
      require("ts_context_commentstring").setup(opts)
      local get_option = vim.filetype.get_option
      vim.filetype.get_option = function(filetype, option)
        return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
          or get_option(filetype, option)
      end
    end,
  },
  {
    "andymass/vim-matchup",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = true, -- Auto close on trailing </
      },
      -- Also override individual filetype configs, these take priority.
      -- Empty by default, useful if one of the "opts" global settings
      -- doesn't work well in a specific filetype
      -- per_filetype = {
      --   ["html"] = {
      --     enable_close = false,
      --   },
      -- },
    },
    config = function(_, opts)
      require("nvim-ts-autotag").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
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
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    ft = { "sh", "c", "cpp", "cuda", "lua", "markdown", "python", "txt", "go", "rust", "mojo" },
    opts = {
      indent = {
        enable = false,
      },
      -- highlight = {
      --   enable = (string.find(vim.api.nvim_list_uis()[1].term_name, "xterm%-256color") ~= nil)
      --     or (string.find(vim.api.nvim_list_uis()[1].term_name, "tmux%-256color") ~= nil)
      --     or (string.find(vim.api.nvim_list_uis()[1].term_name, "screen%-256color") ~= nil)
      --     or (string.find(vim.api.nvim_list_uis()[1].term_name, "alacritty") ~= nil)
      --     or (vim.fn.has("win32") == 1),
      -- },
      highlight = false,
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
      refactor = {
        highlight_definitions = {
          enable = false,
          -- Set to false if you have an `updatetime` of ~100.
          clear_on_cursor_move = false,
        },
        smart_rename = {
          enable = false,
        },
        navigation = {
          enable = true,
          -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
          keymaps = {
            goto_definition = false,
            list_definitions = false,
            list_definitions_toc = false,
            goto_next_usage = false,
            goto_previous_usage = false,
          },
        },
        highlight_current_scope = { enable = false },
      },
      matchup = {
        enable = true, -- mandatory, false will disable the whole extension
        disable_virtual_text = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      local next_usage = require("nvim-treesitter-refactor.navigation").goto_next_usage
      local prev_usage = require("nvim-treesitter-refactor.navigation").goto_previous_usage
      local ok, ts_repeat_move = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
      if ok then
        next_usage, prev_usage = ts_repeat_move.make_repeatable_move_pair(next_usage, prev_usage)
      end
      vim.keymap.set({ "n" }, "<leader>]", next_usage)
      vim.keymap.set({ "n" }, "<leader>[", prev_usage)
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
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
      {
        "polirritmico/telescope-lazy-plugins.nvim",
        keys = {
          { "<space>p", "<Cmd>Telescope lazy_plugins<CR>", desc = "Telescope: Plugins configurations" },
        },
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
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
          preview = true,
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          lazy_plugins = {
            lazy_config = vim.fn.stdpath("config") .. _G.sep .. "init.lua", -- Must be a valid path to the file containing the lazy spec and setup() call.
          },
        },
      })
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("lazy_plugins")
      local builtin = require("telescope.builtin")
      vim.keymap.set({ "n" }, "<space>e", "<cmd>Telescope find_files<cr>", { noremap = true })
      vim.keymap.set({ "n" }, "<space>h", "<cmd>Telescope help_tags<cr>", { noremap = true })
      vim.keymap.set({ "n" }, "<space>b", "<cmd>Telescope buffers<cr>", { noremap = true })
      vim.keymap.set({ "n" }, "<space>g", "<cmd>Telescope live_grep<cr>", { noremap = true })
      vim.keymap.set({ "n" }, "<space>d", "<cmd>Telescope diagnostics<cr>", { noremap = true })
      vim.keymap.set({ "n" }, "<space>r", "<cmd>Telescope lsp_references<cr>", { noremap = true })
    end,
  },
}
