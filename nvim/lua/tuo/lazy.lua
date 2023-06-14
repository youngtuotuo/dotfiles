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
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'linrongbin16/lsp-progress.nvim'
        }
    },
    {
        'linrongbin16/lsp-progress.nvim',
        event = { 'VimEnter' },
    },
    'lukas-reineke/indent-blankline.nvim',
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
    'luukvbaal/stabilize.nvim',
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    },
    "luukvbaal/statuscol.nvim",
    "dstein64/vim-startuptime",
    "nvim-tree/nvim-tree.lua",
    "Pocco81/true-zen.nvim",

    -- productivity
    {
        'grepsuzette/vim-sum',
        config = function()
            vim.cmd [[
                vmap <Leader>a <Plug>VimSumVisual
            ]]
        end
    },
    'tpope/vim-fugitive',
    'sbdchd/neoformat',
    {
        'AmeerTaweel/todo.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
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
          -- Please make sure you install markdown and markdown_inline parser
          {"nvim-treesitter/nvim-treesitter"}
        }
    },
    'lukas-reineke/cmp-under-comparator',
    {
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    },
    {
        'lervag/vimtex',
        ft = {'tex'}
    },
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
        border = "single",
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
