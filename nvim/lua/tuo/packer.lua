local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

pcall(require, "impatient")

local cfg = {
    profile = {
        enable = true,
        threshold = 0 -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
    display = {
        open_fn = function()
            return require("packer.util").float {border = "rounded"}
        end
    }
}

packer.init(cfg)

-- Plugins

require('packer').startup(function()
    -- packer can manage itself
    use {"wbthomason/packer.nvim"}

    -- lsp configuration
    use {
        "neovim/nvim-lspconfig",
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim',

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',
        }
    }

    use({
        "folke/noice.nvim",
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    })

    use {"folke/zen-mode.nvim"}

    use {"folke/twilight.nvim"}

    -- speedup startup time
    use {"lewis6991/impatient.nvim"}

    use {"lewis6991/gitsigns.nvim"}

    use {'tpope/vim-fugitive'}

    use {"sbdchd/neoformat"}

    use {'rose-pine/neovim', as = 'rose-pine'}

    use {"AmeerTaweel/todo.nvim", requires = "nvim-lua/plenary.nvim"}

    use {"windwp/nvim-autopairs"}

    -- latex
    use({"lervag/vimtex"})

    use {
        "nvim-telescope/telescope.nvim",
        branch = '0.1.x',
        requires = {"nvim-lua/plenary.nvim"}
    }

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        cond = vim.fn.executable 'make' == 1
    }

    -- stablizer window split
    use {"luukvbaal/stabilize.nvim", event = "WinEnter"}

    -- treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            pcall(require('nvim-treesitter.install').update {with_sync = true})
        end
    }

    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter'
    }

    -- nvim-tree File explorer
    use {"kyazdani42/nvim-tree.lua"}

    -- cmp related
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "onsails/lspkind-nvim",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            -- "kdheepak/cmp-latex-symbols"
        }
    }

    -- color code visualization
    use {
        "norcalli/nvim-colorizer.lua",
        config = function() require("colorizer").setup() end
    }

    -- indent level indicator
    use {"lukas-reineke/indent-blankline.nvim", event = "BufEnter"}

    -- cool icons to disaply
    use {"kyazdani42/nvim-web-devicons", module = "nvim-web-devicons"}

    -- markdown preview tool
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        ft = {"markdown"}
    })

    -- easy code comment
    use {"numToStr/Comment.nvim"}

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- Usage help
-- use {
--   'myusername/example',        -- The plugin location string
--   -- The following keys are all optional
--   disable = boolean,           -- Mark a plugin as inactive
--   as = string,                 -- Specifies an alias under which to install the plugin
--   installer = function,        -- Specifies custom installer. See "custom installers" below.
--   updater = function,          -- Specifies custom updater. See "custom installers" below.
--   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--   opt = boolean,               -- Manually marks a plugin as optional.
--   bufread = boolean,           -- Manually specifying if a plugin needs BufRead after being loaded
--   branch = string,             -- Specifies a git branch to use
--   tag = string,                -- Specifies a git tag to use. Supports '*' for "latest tag"
--   commit = string,             -- Specifies a git commit to use
--   lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--   run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--   config = string or function, -- Specifies code to run after this plugin is loaded.
--   -- The setup key implies opt = true
--   setup = string or function,  -- Specifies code to run before this plugin is loaded.
--   -- The following keys all imply lazy-loading and imply opt = true
--   cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--   ft = string or list,         -- Specifies filetypes which load this plugin.
--   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--   event = string or list,      -- Specifies autocommand events which load this plugin.
--   fn = string or list          -- Specifies functions which load this plugin.
--   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                                -- with one of these module names, the plugin will be loaded.
--   module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When requiring a string which matches one of these patterns, the plugin will be loaded.
-- }
