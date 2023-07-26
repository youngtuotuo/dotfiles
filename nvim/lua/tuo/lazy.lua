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
    -- basic
    'nvim-lua/plenary.nvim',

    -- ui stuffs
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        'j-hui/fidget.nvim',
        event = 'BufRead',
        tag='legacy',
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        config = function()
            require('lazyload.fidget')
        end,
    },
    'nvim-lualine/lualine.nvim',
    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
        config = function()
            require('lazyload.indent-blankline')
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        config = function()
            require('lazyload.gitsigns')
        end
    },
    'nvim-tree/nvim-web-devicons',
    {
        'norcalli/nvim-colorizer.lua',
        event = 'BufRead',
        config = function()
            require('lazyload.colorizer')
        end,
    },
    {
        "luukvbaal/statuscol.nvim",
        event = 'BufRead',
        config = function()
            require('lazyload.statuscol')
        end
    },
    "folke/zen-mode.nvim",
    -- productivity
    {
        'grepsuzette/vim-sum',
        event = 'InsertEnter',
        config = function()
            require('lazyload.vim-sum')
        end
    },
    'tpope/vim-fugitive',
    {
        'sbdchd/neoformat',
        event = "BufRead",
        config = function()
            require('lazyload.neoformat')
        end,
    },
    {
        'folke/todo-comments.nvim',
        event = 'BufRead',
        config = function()
            require('lazyload.todo')
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        }
    },
    'christoomey/vim-tmux-navigator',
    "folke/twilight.nvim",
    'Kasama/nvim-custom-diagnostic-highlight',


    -- tool box
    {
        "glepnir/lspsaga.nvim",
        event = "BufRead",
        dependencies = {
          -- Please make sure you install markdown and markdown_inline parser
          {"nvim-treesitter/nvim-treesitter"}
        }
    },
    {
        "folke/trouble.nvim",
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        config = function()
            require('lazyload.trouble')
        end,
    },
    {
        'lervag/vimtex',
        ft = {'tex'}
    },
    {
        'numToStr/Comment.nvim',
        event = 'BufRead',
        config = function()
            local config = require('lazyload.Comment')
            require('Comment').setup(config)
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufReadPre',
        build = function()
            pcall(require('nvim-treesitter.install').update {with_sync = true})
        end,
        config = function()
            require('lazyload.treesitter')
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = {'nvim-treesitter'}
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
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
        ft = {'markdown'},
        config = function()
            require('lazyload.markdownpreview')
        end
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'folke/neodev.nvim',
            'hrsh7th/nvim-cmp',
        },
    },
    {
        "microsoft/python-type-stubs",
        cond = false
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = {'nvim-lua/plenary.nvim'}
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = vim.fn.executable 'make' == 1
    },
    'xiyaowong/telescope-emoji.nvim',
    'crispgm/telescope-heading.nvim',
    'debugloop/telescope-undo.nvim',
}

local opts = {
    ui = {
        border = BORDER,
        icons = {
            cmd = "",
            config = "",
            event = "",
            ft = "",
            init = "",
            import = "",
            keys = "",
            -- lazy = "",
            lazy = "󰒲 ",
            loaded = "●",
            not_loaded = "○",
            plugin = " ",
            runtime = " ",
            source = " ",
            start = "",
            task = "✔ ",
            list = {
                "●",
                "➜",
                "★",
                "‒",
            },
        },
    },
}

require("lazy").setup(plugins, opts)
