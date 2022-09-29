-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

pcall(require, "impatient")

local cfg = {
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}


packer.init(cfg)

-- Plugins
return require('packer').startup(function()
  -- packer can manage itself
  use { "wbthomason/packer.nvim" }

  -- faster filetype
  use { "nathom/filetype.nvim" }

  -- speedup startup time
  use { "lewis6991/impatient.nvim", }

  -- telescope
  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup(require("tuo.telescope"))
    end,
    requires = {
      "nvim-lua/plenary.nvim",
      { 
        "rcarriga/nvim-notify",
        config = function()
          vim.notify = require("notify"),
          require("telescope").load_extension("notify")
        end,
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = 'make',
        config = function()
          require("telescope").load_extension('fzf')
        end,
      },
      {
        "folke/todo-comments.nvim",
        config = function()
          require("todo-comments").setup(require("tuo.todo"))
        end,
      },
      -- workspaces manager
      {
        "natecraddock/workspaces.nvim",
        config = function()
          require("workspaces").setup({hooks = {open = "NvimTreeOpen ."}})
          require("telescope").load_extension("workspaces")
        end
      } 
    },
  }

  -- startup screen
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require("alpha").setup(require'alpha.themes.startify'.config)
    end
  }

  -- color scheme
  use {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup(require("tuo.colorscheme"))
    end,
  }

  -- window split stablizer
  use {
    "luukvbaal/stabilize.nvim",
    event = "BufRead",
    config = function()
      require("stabilize").setup()
    end,
  }

  -- main treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "nvim-treesitter/playground",
        "nvim-treesitter/nvim-treesitter-context",  
        module = "treesitter-context",
        config = function()
          require("treesitter-context").setup(require("tuo.treesitter-context"))
        end,
      },
    },
    config = function()
      require("nvim-treesitter.configs").setup(require("tuo.treesitter"))
    end,
  }

  -- AI completion
  -- use { "github/copilot.vim", event = "InsertEnter" }

  -- File explorer
  use {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup(require("tuo.nvimtree"))
    end,
  }

  -- lsp configuration
  use {
    "neovim/nvim-lspconfig",
    -- easy rust lsp configuration tool
    requires = { "simrat39/rust-tools.nvim", module = "rust-tools" },
    config = function()
      require("tuo.nvimlsp")
    end
  }

  -- cmp related
  use {
    "hrsh7th/nvim-cmp",
    config = function()
      require("tuo.nvimcmp").setup()
    end,
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      { "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" },
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "onsails/lspkind-nvim",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets",
    },   
  }

  -- Load only when required
  use { "nvim-lua/plenary.nvim", module = "plenary" }

  -- Git statur indicator in sings
  use {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup()
    end,
  }

  -- color code visualization
  use {
    "norcalli/nvim-colorizer.lua",
    opt = true,
    event = "BufRead",
    config = function()
      require("colorizer").setup()
    end,
  }

  -- indent level indicator
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("indent_blankline").setup {enabled = false, show_end_of_line = true}
    end
  }

  -- cool icons to disaply
  use {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup( { default = true } )
    end,
  }

  -- markdown preview tool
  use {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown" },
    cmd = { "MarkdownPreview" }
  }

  -- easy code comment
  use {
    "numToStr/Comment.nvim",
    opt = true,
    keys = { "gc", "gcc", "gbc" },
    config = function()
      require("Comment").setup(require("tuo.comment"))
    end
  }
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
