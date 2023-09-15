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
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VimEnter",
    config = function()
      require("lazyload.indent-blankline")
    end,
  },
  {
    "theprimeagen/harpoon",
    config = function()
      require("lazyload.harpoon")
    end,
  },
  {
    "folke/tokyonight.nvim",
    event = "VimEnter",
    config = function()
      require("lazyload.colorscheme")
    end,
    lazy = false,
    priority = 1000,
  },
  -- lazy load
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
    "nvim-lualine/lualine.nvim",
    event = "BufRead",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("lazyload.lualine")
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    event = "ColorScheme",
    config = function()
      require("lazyload.webdevicons")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("lazyload.gitsigns")
    end,
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
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lazyload.lspsaga")
    end,
    dependencies = {
      -- Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
      { "neovim/nvim-lspconfig" },
    },
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
    "hrsh7th/nvim-cmp",
    event = "BufRead",
    config = function()
      require("lazyload.nvim-cmp")
    end,
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind-nvim",
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
}

local border = require("tuo.global").border
local opts = {
  ui = {
    border = border,
    icons = {
      cmd = "",
      config = "",
      event = "",
      ft = "",
      init = "",
      import = "",
      keys = "",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = "✔ ",
      list = { "●", "➜", "★", "‒" },
    },
  },
}

require("lazy").setup(plugins, opts)
