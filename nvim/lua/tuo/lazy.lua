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


local default_opts = {noremap = true, silent = false}
local plugins = {
    -- auto load
    'nvim-lua/plenary.nvim',
    'christoomey/vim-tmux-navigator',
    'tpope/vim-fugitive',
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
    },
    -- lazy load
    {
        'nvim-lualine/lualine.nvim',
        event = 'BufRead',
        config = function()
            require('lazyload.lualine')
        end
    },
    {
        'nvim-tree/nvim-web-devicons',
        event = 'ColorScheme',
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
    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufReadPre',
        keys = {
            {'<leader>i', '<cmd>IndentBlanklineToggle<cr>', mode={'n'}, default_opts}
        },
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
    {
        "folke/zen-mode.nvim",
        keys = {
            {'<space>z', '<cmd>ZenMode<cr>', mode = {'n'}, default_opts, desc='ZenMode'}
        },
        config = function()
            require('lazyload.zen-mode')
        end
    },
    {
        'grepsuzette/vim-sum',
        event = {'InsertEnter', 'BufRead'},
        config = function()
            require('lazyload.vim-sum')
        end
    },
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
    {
        "folke/twilight.nvim",
        event = 'BufRead',
        config = function()
            require('lazyload.twilight')
        end
    },
    {
        "glepnir/lspsaga.nvim",
        keys = {
            {"ga", "<cmd>Lspsaga code_action<cr>", mode={'n'}, default_opts },
            {"gn", "<cmd>Lspsaga rename<CR>", mode={'n'}, default_opts},
            {"<space>o", "<cmd>Lspsaga outline<CR>", mode={'n'}, default_opts},
            {"<leader>t", "<cmd>Lspsaga term_toggle<CR>", mode={'n', 't'}, default_opts},
        },
        config = function()
            require('lazyload.lspsaga')
        end,
        dependencies = {
          -- Please make sure you install markdown and markdown_inline parser
          {"nvim-treesitter/nvim-treesitter"}
        }
    },
    {
        "folke/trouble.nvim",
        event = 'BufRead',
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        config = function()
            require('lazyload.trouble')
        end,
    },
    {
        'lervag/vimtex',
        ft = {'tex'},
        keys = {
            {"<leader>vc", "<cmd>VimtexCompile<CR>", mode={"n"}, default_opts}
        },
        config = function()
            require('lazyload.vim-tex')
        end

    },
    {
        'numToStr/Comment.nvim',
        keys = {
            {'gc', mode={'n', 'v'}},{'gb', mode={'n', 'v'}}
        },
        config = function()
            require('lazyload.Comment')
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',
        build = function()
            pcall(require('nvim-treesitter.install').update {with_sync = true})
        end,
        config = function()
            require('lazyload.treesitter')
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = 'BufRead',
        dependencies = {'nvim-treesitter'}
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'BufRead',
        config = function()
            require('lazyload.nvim-cmp')
        end,
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
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
        event = 'BufRead',
        config = function()
            require('lazyload.lspconfig')
        end,
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
        keys = {
            {"<space>a", "<cmd>lua require('telescope.builtin').builtin()<CR>", mode={'n'}, default_opts},
            {"<space>r", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", mode={'n'}, default_opts},
            {"<space>e", "<cmd>lua require('telescope.builtin').find_files()<CR>", mode={'n'}, default_opts},
            {"<space>f", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", mode={'n'}, default_opts},
            {"<space>g", "<cmd>lua require('telescope.builtin').git_files()<CR>", mode={'n'}, default_opts},
            {"<space>d", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", mode={'n'}, default_opts},
            {"<space>l", "<cmd>lua require('telescope.builtin').live_grep()<CR>", mode={'n'}, default_opts},
            {"<space>b", "<cmd>lua require('telescope.builtin').buffers()<CR>", mode={'n'}, default_opts},
            {"<space>c", "<cmd>lua require('telescope.builtin').commands()<CR>", mode={'n'}, default_opts},
            {"<space>h", "<cmd>lua require('telescope.builtin').help_tags()<CR>", mode={'n'}, default_opts},
            {"<space>m", "<cmd>lua require('telescope.builtin').keymaps()<CR>", mode={'n'}, default_opts},
            {"<space>v", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", mode={'n'}, default_opts}
        },
        config = function()
            require('lazyload.telescope')
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
            },
            'crispgm/telescope-heading.nvim',
            'debugloop/telescope-undo.nvim',
        }
    },
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
