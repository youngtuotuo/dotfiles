vim.opt.nu = true
vim.opt.rnu = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

vim.keymap.set({ "n" }, "d_", "d^", { nowait = true, noremap = true })
vim.keymap.set({ "n" }, "c_", "c^", { nowait = true, noremap = true })
vim.keymap.set({ "i" }, ",", "<C-g>u,", { noremap = true })
vim.keymap.set({ "i" }, ".", "<C-g>u.", { noremap = true })
vim.keymap.set({ "t" }, "<esc><esc>", "<C-\\><C-n>", { noremap = true })
vim.keymap.set({ "n" }, "Y", "y$", { noremap = true })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true })

local group = vim.api.nvim_create_augroup("Tuo", { clear = true })
vim.api.nvim_create_autocmd("BufEnter",
  {
    group = group,
    callback = function(args)
      vim.treesitter.stop(args.buf)
    end
  }
)

vim.cmd.packadd [[cfilter]]

-- vim-plug bootstrap installation script for Neovim
local fn = vim.fn
local install_path = '~/.config/nvim/autoload/plug.vim'

-- Check if vim-plug is installed
local function ensure_plug()
    if fn.empty(fn.glob(install_path)) > 0 then
        -- Create required directories
        fn.mkdir('~/.config/nvim/autoload', 'p')

        -- Define installation command
        local install_cmd = string.format(
            'curl -fLo %s --create-dirs ' .. 
            'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
            install_path
        )

        -- Execute installation command
        print("Installing vim-plug...")
        local output = fn.system(install_cmd)

        -- Check installation status
        if vim.v.shell_error == 0 then
            print("vim-plug installed successfully!")
            -- Schedule PlugInstall to run after vim-plug is loaded
            vim.cmd([[
                autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
            ]])
        else
            error("Failed to install vim-plug: " .. output)
            return false
        end
    end
    return true
end

local function init_plug()
    if ensure_plug() then
      local vim = vim
      local Plug = vim.fn['plug#']
      vim.call('plug#begin')
      Plug('https://github.com/junegunn/vim-easy-align')
      Plug('https://github.com/kaarmu/typst.vim')
      Plug('https://github.com/mbbill/undotree')
      Plug('https://github.com/sheerun/vim-polyglot')
      Plug('https://github.com/tommcdo/vim-exchange')
      Plug('https://github.com/tpope/vim-apathy')
      Plug('https://github.com/tpope/vim-commentary')
      Plug('https://github.com/tpope/vim-endwise')
      Plug('https://github.com/tpope/vim-fugitive')
      Plug('https://github.com/tpope/vim-rsi')
      Plug('https://github.com/tpope/vim-surround')
      Plug('https://github.com/tpope/vim-vinegar')
      Plug('https://github.com/wellle/targets.vim')
      vim.call('plug#end')
    end
end

init_plug()
