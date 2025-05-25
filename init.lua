vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.signcolumn = "yes:1"
vim.opt.guicursor = ""
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

vim.keymap.set({ "i", "n" }, "<C-c>", "<esc>", { noremap = true })
vim.keymap.set({ "i" }, ",", "<C-g>u,", { noremap = true })
vim.keymap.set({ "i" }, ".", "<C-g>u.", { noremap = true })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true })
vim.keymap.set({ "n" }, "-", ":Ex<cr>", { noremap = true })
vim.keymap.set({ "n" }, "grd", ":execute 'lua vim.diagnostic.setloclist()' | lope<cr>", { noremap = true })
vim.keymap.set({ "n" }, "<leader>d", ":lua vim.diagnostic.open_float()<cr>", { noremap = true })

vim.keymap.set({ "n" }, "gt", function()
    local commentstring = vim.api.nvim_get_option_value("commentstring", { scope = "local" })
    local comment_prefix = commentstring:gsub(" %%s", "")
    vim.cmd([[:lvim /]] .. comment_prefix .. [[\s*\(TODO\|WARN\|WARNING\|NOTE\)/ % | lope]])
end, { noremap = true })

vim.cmd.packadd [[cfilter]]

vim.api.nvim_create_augroup('python_ruff', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    group = 'python_ruff',
    pattern = 'python',
    callback = function()
        vim.keymap.set('n', 'gO', ':lvim /^\\(#.*\\)\\@!\\(class\\|\\s*def\\)/ % | lope<CR>', {
            buffer = true,
            silent = true,
        })
    end,
})

-- Create autocommand group
local whitespace_group = vim.api.nvim_create_augroup('WhitespaceHighlight', { clear = true })

-- Highlight trailing whitespace in normal mode
vim.api.nvim_create_autocmd('ModeChanged', {
    pattern = '*:n',
    group = whitespace_group,
    callback = function()
        vim.fn.matchadd('ExtraWhitespace', [[\s\+$]])
    end,
})

-- Clear matches when leaving normal mode
vim.api.nvim_create_autocmd('ModeChanged', {
    pattern = 'n:*',
    group = whitespace_group,
    callback = function()
        vim.fn.clearmatches()
    end,
})

-- Highlight trailing whitespace on buffer enter
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    group = whitespace_group,
    callback = function()
        vim.fn.matchadd('ExtraWhitespace', [[\s\+$]])
    end,
})

-- Set highlight colors
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { ctermbg = 9, bg = 'LightRed' })

vim.lsp.config["ruff"] = {
    cmd = { 'ruff', 'server' },
    filetypes = { "python" },
    root_markers = { "pyproject.toml" },
}
vim.lsp.enable("ruff")

-- vim.lsp.config["ty"] = {
--     cmd = { 'ty', 'server' },
--     filetypes = { "python" },
--     root_markers = { "pyproject.toml" },
--     handlers = {
--         ["textDocument/publishDiagnostics"] = function() end,
--     },
--     offset_encoding = "utf-8"
-- }
-- vim.lsp.enable("ty")

-- vim.lsp.config["pyrefly"] = {
--     cmd = { 'pyrefly', 'lsp' },
--     filetypes = { "python" },
--     root_markers = { "pyproject.toml" },
--     handlers = {
--         ["textDocument/publishDiagnostics"] = function() end,
--     },
--     offset_encoding = "utf-8"
-- }
-- vim.lsp.enable("pyrefly")

vim.lsp.config["basedpyright"] = {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { "python" },
    root_markers = { "pyproject.toml" },
    handlers = {
        ["textDocument/publishDiagnostics"] = function() end,
    },
    on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider = nil
    end,
    settings = {
        basedpyright = {
            disableOrganizeImports = false,
            analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                typeCheckingMode = "off",
            }
        }
    },
    offset_encoding = "utf-8"
}
vim.lsp.enable("basedpyright")

vim.diagnostic.config({ underline = false, virtual_text = false })

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
        { "junegunn/vim-easy-align", cmd = { "EasyAlign" } },
        { "czheo/mojo.vim", ft = { "mojo" } },
        { "tpope/vim-fugitive", cmd = { "G" } },
        { "danymat/neogen", cmd = { "Neogen" }, config = true, version = "*" },
        { "JoosepAlviste/nvim-ts-context-commentstring", opts = { enable_autocmd = false } },
        {
            'Wansmer/treesj',
            cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
            dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
            opts = {}
        },
        {
            "numToStr/Comment.nvim",
            opts = {
                pre_hook = function(ctx)
                    local U = require 'Comment.utils'

                    -- Determine whether to use linewise or blockwise commentstring
                    local type = ctx.ctype == U.ctype.linewise and '__default' or '__multiline'

                    -- Determine the location where to calculate commentstring from
                    local location = nil
                    if ctx.ctype == U.ctype.blockwise then
                        location = {
                            ctx.range.srow - 1,
                            ctx.range.scol,
                        }
                    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                        location = require('ts_context_commentstring.utils').get_visual_start_location()
                    end

                    return require('ts_context_commentstring').calculate_commentstring {
                        key = type,
                        location = location,
                    }
                end
            }
        },
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            ft = { "markdown" },
            build = ":call mkdp#util#install()",
            config = function()
                vim.g.mkdp_open_to_the_world = 1
                vim.g.mkdp_echo_preview_url = 1
                vim.g.mkdp_port = '8088'
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
                sync_install = false,
                auto_install = false,
                highlight = { enable = false },
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
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = { query = "@class.outer", desc = "Next class start" },
                            --
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                },
            },
            config = function(_, opts)
                require'nvim-treesitter.configs'.setup(opts)
            end
        },
        {
            "junegunn/fzf",
            build = ":call fzf#install()",
            init = function()
                vim.g.fzf_layout = { down = "40%" }
            end
        },
        {
            "stevearc/conform.nvim",
            event = { "BufWritePre" },
            cmd = { "ConformInfo" },
            keys = {
                { "<leader>f", function() require("conform").format() end, mode = { "n", "v"} }
            },
            opts = {
                formatters_by_ft = {
                    python = { "ruff_format", "ruff_organize_imports" },
                    -- python = { "ruff_organize_imports" },
                },
            },
            init = function()
                vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
            end
        },
        {
            "kylechui/nvim-surround",
            version = "^3.0.0",
            event = "VeryLazy",
            opts = {}
        }
    }
})

local fn = vim.fn

function _G.qftf(info)
    local items
    local ret = {}

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

    -- Apply syntax highlighting for quickfix window
    vim.schedule(function()
        vim.cmd [[
            " Clear existing quickfix syntax to avoid conflicts
            syntax clear
            " Match filename (up to the separator │)
            syntax match qfFileName /^[^│]*/ contained containedin=qfLine
            " Match line and column numbers (e.g., 123:45)
            syntax match qfLineNr /│\s*\d\+:\d\+│/ contained containedin=qfLine
            " Match error/warning type (e.g., ' E' or ' W')
            syntax match qfType /│[^│]*│\s*[EW]\?\s/ contained containedin=qfLine
            " Match the entire valid line
            syntax match qfLine /^[^│]*│.*$/ contains=qfFileName,qfLineNr,qfType
            " Link highlight groups to default quickfix highlights
            highlight default link qfFileName Directory
            highlight default link qfLineNr LineNr
            highlight default link qfType Type
        ]]
    end)
    return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
