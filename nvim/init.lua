vim.opt.nu = true
vim.opt.rnu = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.colorcolumn = "120"
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

vim.keymap.set({ "i" }, ",", "<C-g>u,", { noremap = true })
vim.keymap.set({ "i" }, ".", "<C-g>u.", { noremap = true })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true })

vim.cmd.packadd [[cfilter]]

-- vim-plug bootstrap installation script for Neovim
local fn = vim.fn
local install_path = os.getenv("HOME") .. "/.config/nvim/autoload/plug.vim"

-- Check if vim-plug is installed
local function ensure_plug()
    if fn.empty(fn.glob(install_path)) > 0 then
        -- Create required directories
        fn.mkdir(os.getenv("HOME") .. "/.config/nvim/autoload", "p")

        -- Define installation command
        local install_cmd = string.format(
            "curl -fLo %s --create-dirs " .. 
            "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim",
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
      local Plug = vim.fn["plug#"]
      vim.call("plug#begin")
      Plug("https://github.com/kaarmu/typst.vim")
      vim.call("plug#end")
    end
end

init_plug()
