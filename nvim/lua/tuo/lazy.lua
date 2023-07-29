local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

local default_opts = {noremap = true, silent = false}
local plugins = {
    -- auto load
    'nvim-lua/plenary.nvim', -- 'christoomey/vim-tmux-navigator',
    'tpope/vim-fugitive', -- lazy load
    {
        'kessejones/term.nvim',
        keys = {{"<leader>t", "<cmd>lua require('term').toggle()<CR>", mode = {'n', 't'}, default_opts}},
        config = function() require('lazyload.term') end
    }, {'mbbill/undotree', event = 'BufRead', keys = {{"<leader>u", ":UndotreeToggle<cr>", mode = "n"}}}, {
        "rebelot/kanagawa.nvim",
        event = 'VimEnter',
        config = function() require('lazyload.colorscheme') end,
        lazy = false,
        priority = 1000
    }, {
        'nvim-lualine/lualine.nvim',
        event = 'BufRead',
        dependencies = {'neovim/nvim-lspconfig'},
        config = function() require('lazyload.lualine') end
    }, {'nvim-tree/nvim-web-devicons', event = 'ColorScheme'}, {
        'j-hui/fidget.nvim',
        event = 'BufRead',
        tag = 'legacy',
        dependencies = {'neovim/nvim-lspconfig'},
        config = function() require('lazyload.fidget') end
    }, {
        'lukas-reineke/indent-blankline.nvim',
        event = 'VimEnter',
        keys = {{'<leader>i', ':IndentBlanklineToggle<cr>', mode = {'n'}, default_opts}},
        config = function() require('lazyload.indent-blankline') end
    }, {'lewis6991/gitsigns.nvim', event = 'BufRead', config = function() require('lazyload.gitsigns') end},
    {'norcalli/nvim-colorizer.lua', event = 'BufRead', config = function() require('lazyload.colorizer') end},
    {"luukvbaal/statuscol.nvim", event = 'BufRead', config = function() require('lazyload.statuscol') end}, {
        "folke/zen-mode.nvim",
        keys = {{'<space>z', ':ZenMode<cr>', mode = {'n'}, default_opts, desc = 'ZenMode'}},
        config = function() require('lazyload.zen-mode') end
    }, {'grepsuzette/vim-sum', event = {'InsertEnter', 'BufRead'}, config = function() require('lazyload.vim-sum') end},
    {
        'mhartington/formatter.nvim',
        cmd = {"Format", "FormatWrite", "FormatLock", "FormatWriteLock"},
        event = "BufRead",
        config = function() require('lazyload.formatter') end
    }, {
        'folke/todo-comments.nvim',
        event = 'BufRead',
        config = function() require('lazyload.todo') end,
        dependencies = {'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim'}
    }, {"folke/twilight.nvim", event = 'BufRead', config = function() require('lazyload.twilight') end}, {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        keys = {
            {"ga", ":Lspsaga code_action<cr>", mode = {'n'}, default_opts},
            {"gn", ":Lspsaga rename<CR>", mode = {'n'}, default_opts},
            {"<space>o", "<cmd>Lspsaga outline<CR>", mode = {'n'}, default_opts}
        },
        config = function() require('lazyload.lspsaga') end,
        dependencies = {
            -- Please make sure you install markdown and markdown_inline parser
            {"nvim-treesitter/nvim-treesitter"}, {'neovim/nvim-lspconfig'}
        }
    }, {
        "folke/trouble.nvim",
        event = 'BufRead',
        keys = {
            {"<space>d", ":TroubleToggle<cr>", mode = {'n'}, default_opts},
        },
        dependencies = {'neovim/nvim-lspconfig'},
        config = function() require('lazyload.trouble') end
    }, {
        'lervag/vimtex',
        ft = {'tex'},
        keys = {{"<leader>vc", ":VimtexCompile<CR>", mode = {"n"}, default_opts}},
        config = function() require('lazyload.vim-tex') end

    }, {
        'numToStr/Comment.nvim',
        keys = {{'gc', mode = {'n', 'v'}}, {'gb', mode = {'n', 'v'}}},
        config = function() require('lazyload.Comment') end
    }, {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',
        build = function() pcall(require('nvim-treesitter.install').update {with_sync = true}) end,
        config = function() require('lazyload.treesitter') end
    }, {'nvim-treesitter/nvim-treesitter-textobjects', event = 'BufRead', dependencies = {'nvim-treesitter'}}, {
        'hrsh7th/nvim-cmp',
        event = 'BufRead',
        config = function() require('lazyload.nvim-cmp') end,
        dependencies = {
            'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'onsails/lspkind-nvim', 'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-nvim-lua', 'hrsh7th/cmp-nvim-lsp', 'rafamadriz/friendly-snippets',
            'hrsh7th/cmp-nvim-lsp-signature-help'
        }
    }, {
        'iamcco/markdown-preview.nvim',
        build = 'cd app && npm install',
        ft = {'markdown'},
        config = function() require('lazyload.markdownpreview') end
    }, {
        'williamboman/mason-lspconfig.nvim',
        ft = {"lua", "c", "cpp", "rust", "tex", "html", "python", "yaml", "go", "haskell", "xml"},
        dependencies = {
            {
                'neovim/nvim-lspconfig',
                event = 'BufRead',
                cmd = {"LspInfo"},
                dependencies = {'folke/neodev.nvim', 'hrsh7th/nvim-cmp'}
            }, {
                'williamboman/mason.nvim',
                event = 'BufRead',
                cmd = {"Mason"},
                config = function() require('lazyload.lspconfig') end,
                dependencies = {'neovim/nvim-lspconfig'}
            }
        }
    }, {"microsoft/python-type-stubs", cond = false}, {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        keys = {
            {"<space>a", ":lua require('telescope.builtin').builtin()<CR>", mode = {'n'}, default_opts},
            {"<space>r", ":lua require('telescope.builtin').lsp_references()<CR>", mode = {'n'}, default_opts},
            {"<space>e", ":lua require('telescope.builtin').find_files()<CR>", mode = {'n'}, default_opts},
            {
                "<space>f",
                ":lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>",
                mode = {'n'},
                default_opts
            }, {"<space>g", ":lua require('telescope.builtin').git_files()<CR>", mode = {'n'}, default_opts},
            -- {"<space>d", ":lua require('telescope.builtin').diagnostics()<CR>", mode = {'n'}, default_opts},
            {"<space>l", ":lua require('telescope.builtin').live_grep()<CR>", mode = {'n'}, default_opts},
            {"<space>b", ":lua require('telescope.builtin').buffers()<CR>", mode = {'n'}, default_opts},
            {"<space>c", ":lua require('telescope.builtin').commands()<CR>", mode = {'n'}, default_opts},
            {"<space>h", ":lua require('telescope.builtin').help_tags()<CR>", mode = {'n'}, default_opts},
            {"<space>m", ":lua require('telescope.builtin').keymaps()<CR>", mode = {'n'}, default_opts},
            {"<space>v", ":lua require('telescope.builtin').lsp_document_symbols()<CR>", mode = {'n'}, default_opts},
            {"<space>u", ":lua require('telescope').extensions.undo.undo()<CR>", mode = {'n'}, default_opts},
            {"<space>3", ":lua require('telescope').extensions.heading.heading()<CR>", mode = {'n'}, default_opts}
        },
        config = function() require('lazyload.telescope') end,
        dependencies = {
            'nvim-lua/plenary.nvim', {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            }, 'crispgm/telescope-heading.nvim', 'debugloop/telescope-undo.nvim'
        }
    }, {
        'theprimeagen/harpoon',
        event = 'BufRead',
        keys = {
            {"<leader>a", ":lua require('harpoon.mark').add_file()<cr>", mode = "n", default_opts},
            {"<C-q>", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", mode = "n", default_opts},
            {"<M-1>", ":lua require('harpoon.ui').nav_file(1)<cr>", mode = "n", default_opts},
            {"<M-2>", ":lua require('harpoon.ui').nav_file(2)<cr>", mode = "n", default_opts},
            {"<M-3>", ":lua require('harpoon.ui').nav_file(3)<cr>", mode = "n", default_opts},
            {"<M-4>", ":lua require('harpoon.ui').nav_file(4)<cr>", mode = "n", default_opts}
        },
        config = function() require('lazyload.harpoon') end
    }
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
            list = {"●", "➜", "★", "‒"}
        }
    }
}

require("lazy").setup(plugins, opts)
