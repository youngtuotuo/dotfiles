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

pcall(require, "impatient")

local plugins = {
    -- basic
    'lewis6991/impatient.nvim',
    'nvim-lua/plenary.nvim',

    -- ui stuffs
    {
        'navarasu/onedark.nvim',
        lazy = false,
        priority = 1000,
    },
    "rebelot/kanagawa.nvim",
    {
        "catppuccin/nvim",
        name = "catppuccin"
    },
    'nvim-tree/nvim-web-devicons',
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'arkav/lualine-lsp-progress'
        }
    },
    'lukas-reineke/indent-blankline.nvim',
    'kyazdani42/nvim-tree.lua',
    'lewis6991/gitsigns.nvim',
    'luukvbaal/stabilize.nvim',
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    },

    -- productivity
    'tpope/vim-fugitive',
    'sbdchd/neoformat',
    {
        'AmeerTaweel/todo.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
    'windwp/nvim-autopairs',
    'christoomey/vim-tmux-navigator',
    {
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup {}
      end
    },
    {
      'Kasama/nvim-custom-diagnostic-highlight',
      config = function()
        require('nvim-custom-diagnostic-highlight').setup {
            patterns_override = {
            -- Lua patterns to be tested against the diagnostic message. Overrides default behavior
            '%sunused', '^unused', 'not used', 'never used',
            'not read', 'never read', 'empty block', 'not accessed'
          },

        }
      end
    },


    -- tool box
    {
        "glepnir/lspsaga.nvim",
        event = "BufRead",
        dependencies = {
          {"nvim-tree/nvim-web-devicons"},
          -- Please make sure you install markdown and markdown_inline parser
          {"nvim-treesitter/nvim-treesitter"}
        }
    },
    'lukas-reineke/cmp-under-comparator',
    {
      "folke/trouble.nvim",
      dependencies = "nvim-tree/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    },
    {
      "smjonas/inc-rename.nvim",
      config = function()
        require("inc_rename").setup()
      end,
    },
    'lervag/vimtex',
    'numToStr/Comment.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            pcall(require('nvim-treesitter.install').update {with_sync = true})
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = {'nvim-treesitter'}
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'onsails/lspkind-nvim',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'rafamadriz/friendly-snippets',
            'hrsh7th/cmp-nvim-lsp-signature-help',
        }
    },
    {
        'iamcco/markdown-preview.nvim',
        build = 'cd app && npm install',
        ft = {'markdown'}
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'folke/neodev.nvim',
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {'nvim-lua/plenary.nvim'}
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = vim.fn.executable 'make' == 1
    },
}

local opts = {
    ui = {
        border = "single"
    },
    checker = {
        enabled = true,
    }
}

require("lazy").setup(plugins, opts)




