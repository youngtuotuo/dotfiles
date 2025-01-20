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

vim.cmd.packadd [[cfilter]]

-- Highlight the 80th character if line is longer
local function highlight_eightieth_char()
    -- Clear any existing matches
    vim.fn.clearmatches()
    
    -- Get the number of lines in the buffer
    local line_count = vim.fn.line("$")
    
    -- Iterate through all lines
    for line_num = 1, line_count do
        -- Get the content of the current line
        local content = vim.fn.getline(line_num)
        
        -- If line is longer than 80 characters
        if #content >= 80 then
            -- Match exactly the 80th character
            local pattern = "\\%" .. line_num .. "l\\%80v."
            -- Add a match with custom highlighting
            vim.fn.matchadd("EightiethChar", pattern)
        end
    end
end

-- Define custom highlight group
vim.api.nvim_set_hl(0, "EightiethChar", { ctermbg="red", bg="NvimLightRed" })

-- Create autocommand group
local augroup = vim.api.nvim_create_augroup(
    "HighlightEightiethChar", { clear = true })

-- Set up autocommands
vim.api.nvim_create_autocmd(
    { "BufEnter", "BufRead", "TextChanged", "InsertLeave" }, {
    group = augroup,
    callback = highlight_eightieth_char
})

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
      Plug("https://github.com/sheerun/vim-polyglot")
      vim.call("plug#end")
    end
end

init_plug()
