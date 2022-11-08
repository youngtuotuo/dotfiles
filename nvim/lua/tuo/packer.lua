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

  -- speedup startup time
  use { "lewis6991/impatient.nvim", }

  use { "sbdchd/neoformat",
    config = function()
      vim.cmd [[
        let g:neoformat_cpp_clangformat = {
              \ 'exe': 'clang-format',
              \ 'args': ['--style="{IndentWidth: 4}"'],
              \ }
        let g:neoformat_enabled_cpp = ['clangformat']
      ]]
    end
  }

  use { 'shaunsingh/nord.nvim',
    config = function()
      vim.g.nord_italic = false
      vim.cmd [[colo nord]]
    end
  }

  use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  -- latex
  use ({
    "lervag/vimtex",
    config = function()
      vim.cmd [[
        let g:vimtex_view_method=(has("win32")?"general":"zathura")
        let g:tex_flavor="latex"
        set conceallevel=2
        " let g:vimtex_compiler_latexmk = { 
        "   \ 'executable' : 'latexmk',
        "   \ 'options' : [ 
        "   \   '-xelatex',
        "   \   '-file-line-error',
        "   \   '-synctex=1',
        "   \   '-interaction=nonstopmode',
        "   \ ],
        "   \}
        let g:vimtex_compiler_latexmk_engines = {
          \ '_' : '-xelatex',
          \}
        let g:vimtex_quickfix_enabled=0
      ]]
    end
  })

  -- telescope
  local tele_fzf_run = "make"
  if vim.fn.has("win32") == 1 then
    tele_fzf_run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
  end
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = tele_fzf_run,
    config = function()
      if vim.fn.has("win32") == 0 then
        require("telescope").load_extension('fzf')
      end
    end,
  }

  use {
    "natecraddock/workspaces.nvim",
    config = function()
      require("workspaces").setup({hooks = {open = "NvimTreeOpen ."}})
      require("telescope").load_extension("workspaces")
    end
  } 

  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup(require("tuo.telescope"))
    end,
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }

  -- stablizer window split
  use {
    "luukvbaal/stabilize.nvim",
    event = "WinEnter",
    config = function()
      require("stabilize").setup()
    end,
  }

  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    event = "BufEnter",
    requires = {
      { 
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "BufEnter",
        after = "nvim-treesitter",
      },
    },
    config = function()
      require("nvim-treesitter.configs").setup(require("tuo.treesitter"))
    end,
  }

  -- AI completion
  -- use { "github/copilot.vim", event = "InsertEnter" }

  -- nvim-tree File explorer
  use {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup(require("tuo.nvimtree"))
    end,
  }

  -- lsp configuration
  use {
    "neovim/nvim-lspconfig",
    event = "BufEnter",
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
      "hrsh7th/cmp-cmdline",
      -- "hrsh7th/cmp-nvim-lsp-signature-help",
      "onsails/lspkind-nvim",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets",
      "kdheepak/cmp-latex-symbols",
    },   
  }

  -- Load only when required
  use { "nvim-lua/plenary.nvim", module = "plenary" }

  -- gitsigns Git status indicator in sings
  -- use {
  --   "lewis6991/gitsigns.nvim",
  --   event = "BufReadPre",
  --   requires = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("gitsigns").setup()
  --   end,
  -- }

  -- color code visualization
  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufEnter",
    config = function()
      require("colorizer").setup()
    end,
  }

  -- indent level indicator
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
    config = function()
      vim.cmd [[
        hi IndentBlanklineContextStart cterm=nocombine gui=nocombine
        hi IndentBlanklineContextChar guifg=LightGrey
      ]]
      require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = false,
        show_first_indent_level = false,
        enabled = false,
        show_end_of_line = true
    }
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
  use({ "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_open_to_the_world = 1
      vim.g.mkdp_open_ip = '127.0.0.1'
      vim.g.mkdp_port = 8085
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_browser = ''
      vim.g.mkdp_browserfunc = ''
      -- vim.cmd [[function! g:Open_browser(url)
      --     silent exe '!/opt/microsoft/msedge/msedge 'a:url
      -- endfunction]]
      -- vim.g.mkdp_browserfunc = 'g:Open_browser'
    end,
    ft = { "markdown" },
  })

  -- easy code comment
  use {
    "numToStr/Comment.nvim",
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
