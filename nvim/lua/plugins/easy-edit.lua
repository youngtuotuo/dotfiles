return {
  {
    "tpope/vim-vinegar",
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
    "chrisgrieser/nvim-various-textobjs",
    opts = { useDefaultKeymaps = false },
    config = function(_, opts)
      require("various-textobjs").setup(opts)
      vim.keymap.set({ "o", "x" }, "as", '<cmd>lua require("various-textobjs").subword("outer")<CR>')
      vim.keymap.set({ "o", "x" }, "is", '<cmd>lua require("various-textobjs").subword("inner")<CR>')
    end,
  },
  {
    "kylechui/nvim-surround",
    -- Use for stability; omit to use `main` branch for the latest features
    version = "*",
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format()
        end,
        mode = { "n", "v" },
        noremap = true,
        desc = "Format buffer",
      },
    },
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
    },
    config = function(_, opts)
      require("conform").setup(opts)
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
  {
    "andymass/vim-matchup",
    ft = { "sh", "c", "cpp", "cuda", "lua", "markdown", "python", "txt", "go", "rust", "mojo" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "xml" },
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
    },
    config = function(_, opts)
      require("nvim-ts-autotag").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    cmd = { "TSUpdate" },
    ft = { "sh", "c", "cpp", "cuda", "lua", "markdown", "python", "txt", "go", "rust", "mojo" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
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
      matchup = {
        enable = true, -- mandatory, false will disable the whole extension
        disable_virtual_text = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    keys = {
      { "<space>e", function() require("telescope.builtin").find_files() end, mode = { "n" }, noremap = true },
      { "<space>h", function() require("telescope.builtin").help_tags() end, mode = { "n" }, noremap = true },
      { "<space>b", function() require("telescope.builtin").buffers() end, mode = { "n" }, noremap = true },
      { "<space>g", function() require("telescope.builtin").live_grep() end, mode = { "n" }, noremap = true },
      { "<space>d", function() require("telescope.builtin").diagnostics() end, mode = { "n" }, noremap = true },
      { "<space>r", function() require("telescope.builtin").lsp_references() end, mode = { "n" }, noremap = true },
    },
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
        },
      })
      require("telescope").load_extension("fzf")
    end,
  },
}
