local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- auto load
  "nvim-lua/plenary.nvim",
  "tpope/vim-fugitive",
  "tpope/vim-vinegar",
  "Vimjas/vim-python-pep8-indent",
  "catppuccin/nvim",
  "p00f/alabaster.nvim",
  'Mofiqul/vscode.nvim',
  { "microsoft/python-type-stubs", cond = false },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    config = function()
      require("lazyload.telescope")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
      "crispgm/telescope-heading.nvim",
      "debugloop/telescope-undo.nvim",
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} },
    config = function()
      require("lazyload.harpoon")
    end,
  },
  -- lazy load
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufRead",
    config = function()
      require("lazyload.indent_blankline")
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("lazyload.colorizer")
    end,
  },
  {
    "ziglang/zig.vim",
    ft = { "zig" },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("lazyload.gitsigns")
    end,
  },
  {
    "stevearc/aerial.nvim",
    event = "LspAttach",
    config = function()
      require("lazyload.aerial")
    end
  },
  {
    "luukvbaal/statuscol.nvim",
    event = "BufRead",
    config = function()
      require("lazyload.statuscol")
    end,
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("lazyload.zen-mode")
    end,
  },
  {
    "mhartington/formatter.nvim",
    event = "BufRead",
    config = function()
      require("lazyload.formatter")
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("lazyload.todo")
    end,
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  },
  {
    "folke/twilight.nvim",
    event = "BufRead",
    config = function()
      require("lazyload.twilight")
    end,
  },
  {
    "lervag/vimtex",
    ft = { "tex" },
    config = function()
      require("lazyload.vim-tex")
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("lazyload.Comment")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    config = function()
      require("lazyload.treesitter")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufRead",
    dependencies = { "nvim-treesitter" },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufRead",
    dependencies = { "nvim-treesitter" },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "BufRead",
    config = function()
      require("lazyload.nvim-cmp")
    end,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
      require("lazyload.markdownpreview")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    ft = { "lua", "c", "cpp", "rust", "tex", "html", "python", "yaml", "go", "haskell", "xml" },
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        event = "BufRead",
        cmd = { "LspInfo" },
        dependencies = { "folke/neodev.nvim", "hrsh7th/nvim-cmp" },
      },
      {
        "williamboman/mason.nvim",
        event = "BufRead",
        cmd = { "Mason" },
        config = function()
          require("lazyload.lspconfig")
        end,
        dependencies = { "neovim/nvim-lspconfig" },
      },
    },
  },
}

local border = require("tuo.global").border
local opts = {
  ui = {
    border = border,
  },
}

require("lazy").setup(plugins, opts)
vim.keymap.set("n", "<leader>l", ":Lazy<cr>", { noremap = true })
