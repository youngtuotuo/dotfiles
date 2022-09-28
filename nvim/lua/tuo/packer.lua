-- Automatically install packer
-- TODO only for linux, add windows and mac conditions
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
if not status_ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}
-- Plugins
return require('packer').startup(function()
  -- packer can manage itself
  use {"wbthomason/packer.nvim"}
  -- color
  use {"norcalli/nvim-colorizer.lua"}
  use {"lukas-reineke/indent-blankline.nvim"}
  use {"kyazdani42/nvim-web-devicons"}
  use {"catppuccin/nvim"}
  -- workspace
  use {"kyazdani42/nvim-tree.lua"}
  use {"natecraddock/workspaces.nvim"}
  -- stablizer
  use {"luukvbaal/stabilize.nvim"}
  -- treesitter
  use {"nvim-treesitter/nvim-treesitter"}
  use {"nvim-treesitter/nvim-treesitter-textobjects"}
  use {"nvim-treesitter/playground"}
  use {"nvim-treesitter/nvim-treesitter-context"}
  -- lsp
  use {"onsails/lspkind-nvim"}
  use {"neovim/nvim-lspconfig"}
  use {"simrat39/rust-tools.nvim"}
  -- nvim-cmp
  use {"hrsh7th/nvim-cmp"}
  use {"hrsh7th/cmp-nvim-lsp"}
  use {"hrsh7th/cmp-nvim-lua"}
  use {"hrsh7th/cmp-buffer"}
  use {"hrsh7th/cmp-path"}
  use {"hrsh7th/cmp-cmdline"}
  use {"L3MON4D3/LuaSnip"}
  use {"saadparwaiz1/cmp_luasnip"}
  use {"rafamadriz/friendly-snippets"}
  -- markdown
  use {
    "iamcco/markdown-preview.nvim",
    run = 'cd app && yarn install',
    setup = function() vim.g.mkdp_filetypes = {"markdown"} end,
    ft = {"markdown"}
  }
  -- TODO
  use {"folke/todo-comments.nvim"}
  -- comment
  use {"numToStr/Comment.nvim"}
  -- telescope
  use {"nvim-telescope/telescope-fzy-native.nvim", run = 'make'}
  use {"nvim-lua/plenary.nvim"}
  use {"nvim-telescope/telescope.nvim"}
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
