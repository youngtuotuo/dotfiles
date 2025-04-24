vim.opt.nu = true
vim.opt.rnu = true
vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.guicursor = [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175]]

vim.keymap.set({ "i" }, ",", "<C-g>u,", { noremap = true })
vim.keymap.set({ "i" }, ".", "<C-g>u.", { noremap = true })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true })

vim.cmd.packadd [[cfilter]]
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*:n",
    callback = function()
        vim.fn.matchadd("ExtraWhitespace", [[\s\+$]])
    end,
})
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "n:*",
    callback = function()
        vim.fn.clearmatches()
    end,
})
vim.api.nvim_set_hl(0, "ExtraWhitespace", { ctermbg = 9, bg = "NvimLightRed" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.opt_local.makeprg = [[ruff check % -q]]
        vim.opt_local.errorformat = [[%f:%l:%c: %m,%-G %.%#,%-G%.%#]]
        vim.keymap.set(
            "n",
            "gO",
            ":lvim /^\\(\\s*#\\)\\@!\\(\\s*def\\|\\s*class\\)/ %<CR>",
            { buffer = true, noremap = true, silent = true }
        )
    end,
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    install = { colorscheme = { "default" } },
    spec = {
        {
            "kevinhwang91/nvim-bqf",
            opts = {
                preview = {
                    auto_preview = false
                }
            },
            config = function(_, opts)
                require("bqf").setup(opts)
                local fn = vim.fn

                function _G.qftf(info)
                    local items
                    local ret = {}
                    -- The name of item in list is based on the directory of quickfix window.
                    -- Change the directory for quickfix window make the name of item shorter.
                    -- It's a good opportunity to change current directory in quickfixtextfunc :)
                    --
                    -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
                    -- local root = getRootByAlterBufnr(alterBufnr)
                    -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
                    --
                    if info.quickfix == 1 then
                        items = fn.getqflist({id = info.id, items = 0}).items
                    else
                        items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
                    end
                    local limit = 31
                    local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
                    local validFmt = '%s │%5d:%-3d│%s %s'
                    for i = info.start_idx, info.end_idx do
                        local e = items[i]
                        local fname = ''
                        local str
                        if e.valid == 1 then
                            if e.bufnr > 0 then
                                fname = fn.bufname(e.bufnr)
                                if fname == '' then
                                    fname = '[No Name]'
                                else
                                    fname = fname:gsub('^' .. vim.env.HOME, '~')
                                end
                                -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                                if #fname <= limit then
                                    fname = fnameFmt1:format(fname)
                                else
                                    fname = fnameFmt2:format(fname:sub(1 - limit))
                                end
                            end
                            local lnum = e.lnum > 99999 and -1 or e.lnum
                            local col = e.col > 999 and -1 or e.col
                            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
                            str = validFmt:format(fname, lnum, col, qtype, e.text)
                        else
                            str = e.text
                        end
                        table.insert(ret, str)
                    end
                    return ret
                end

                vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
            end
        },
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            dependencies = {"nvim-treesitter/nvim-treesitter"}
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            opts = {
                ensure_installed = { "python" },
                sync_install = false,
                auto_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V', -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                        include_surrounding_whitespace = false,
                    },
                },
            },
            config = function(_, opts)
                require'nvim-treesitter.configs'.setup(opts)
            end
        }
    },
})
