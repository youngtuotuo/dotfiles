vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.hlsearch = true
vim.opt.wrap = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.signcolumn = "yes:1"
vim.opt.guicursor = ""
vim.opt.termguicolors = false
vim.opt.formatoptions:append("ro")

vim.keymap.set({ "i", "n" }, "<C-c>", "<esc>", { noremap = true })
vim.keymap.set({ "i" }, ",", "<C-g>u,", { noremap = true })
vim.keymap.set({ "i" }, ".", "<C-g>u.", { noremap = true })
vim.keymap.set({ "n" }, "J", "mzJ`z", { noremap = true })
vim.keymap.set({ "n" }, "grd", ":execute 'lua vim.diagnostic.setloclist()' | lope<cr>", { noremap = true })
vim.keymap.set({ "n" }, "<leader>d", ":lua vim.diagnostic.open_float()<cr>", { noremap = true })
vim.keymap.set({ "n" }, "gt", function()
    local commentstring = vim.api.nvim_get_option_value("commentstring", { scope = "local" })
    local comment_prefix = commentstring:gsub(" %%s", "")
    vim.cmd([[:lvim /]] .. comment_prefix .. [[\s*\(TODO\|WARN\|WARNING\|NOTE\)/ % | lope]])
end, { noremap = true })

vim.cmd.packadd [[cfilter]]

vim.api.nvim_create_augroup("python", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "python",
    pattern = "python",
    callback = function()
        vim.keymap.set("n", "gO", [[:lvim /^\(#.*\)\@!\(class\|\s*def\)/ % | lope<CR>]], {
            buffer = true,
            silent = true,
        })
    end,
})

vim.api.nvim_create_augroup("fktreesitter", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
    group = "fktreesitter",
    pattern = "*",
    callback = function()
        vim.treesitter.stop()
    end,
})

vim.lsp.config["ruff"] = {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml" },
}
vim.lsp.enable("ruff")

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

local fn = vim.fn

function _G.qftf(info)
    local items
    local ret = {}
    local validFmt

    if info.quickfix == 1 then
        items = fn.getqflist({id = info.id, items = 0}).items
    else
        items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end

    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ""
        local str
        if e.valid == 1 and info.quickfix == 1 then
            local qtype = e.type == "" and '' or " " .. e.type:sub(1, 1):upper()
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == "" then
                    fname = "[No Name]"
                end
            end
            validFmt = "%s | %s"
            str = validFmt:format(fname, e.text)
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

vim.o.qftf = [[{info -> v:lua._G.qftf(info)}]]

-- Set data directory based on Neovim or Vim
local data_dir = vim.fn.has('nvim') and vim.fn.stdpath('data') .. '/site' or vim.fn.expand('~/.vim')

-- Check if plug.vim exists and install if it doesn't
if vim.fn.empty(vim.fn.glob(data_dir .. '/autoload/plug.vim')) == 1 then
  -- Download plug.vim
  vim.fn.system({
    'curl',
    '-fLo',
    data_dir .. '/autoload/plug.vim',
    '--create-dirs',
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  })

  -- Set up autocommand to install plugins and source config
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      vim.cmd('PlugInstall --sync')
      vim.cmd('source ' .. vim.env.MYVIMRC)
    end,
    once = true
  })
end

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug("junegunn/vim-easy-align", { ['on'] = 'EasyAlign' })
Plug("czheo/mojo.vim", { ['for'] = 'mojo' })
Plug("tpope/vim-fugitive", { ['on'] = 'G' })
Plug("tpope/vim-eunuch")
Plug("tpope/vim-rsi")
Plug("tpope/vim-ragtag")
Plug("tpope/vim-vinegar")
Plug("kylechui/nvim-surround")
Plug("easymotion/vim-easymotion")
Plug("tpope/vim-characterize")
Plug("ku1ik/vim-pasta")
Plug("neomake/neomake")
Plug("mhinz/vim-grepper", { ['on'] = { "Grepper", "<plug>(GrepperOperator)"}})
Plug("numToStr/Comment.nvim")
Plug("iamcco/markdown-preview.nvim", { ['do'] = function() vim.fn['mkdp#util#install']() end, ['for'] = { 'markdown', 'vim-plug' } })
Plug("junegunn/fzf", { ['on'] = "FZF", ['do'] = function() vim.fn['fzf#install']() end})
Plug("stevearc/conform.nvim")
Plug("jacoborus/tender.vim")
vim.call('plug#end')

vim.g.plug_window = "vertical new"

vim.cmd.colo [[tender]]
vim.api.nvim_set_hl(0, "Normal", { bg = "none", ctermbg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none", ctermbg = "none" })
-- vim.api.nvim_set_hl(0, "Pmenu", { bg = "DarkGrey", ctermbg = "DarkGrey" })
-- vim.api.nvim_set_hl(0, "PmenuSel", { fg = "Black", bg = "LightGrey", ctermfg = "Black", ctermbg = "LightGrey" })

require("nvim-surround").setup()
require("Comment").setup()
vim.g.mkdp_open_to_the_world = 1
vim.g.mkdp_echo_preview_url = 1
vim.g.mkdp_port = '8088'
vim.g.fzf_layout = { down = "40%" }
require("conform").setup( {
    formatters_by_ft = { python = { "ruff_format", "ruff_organize_imports" }, }
})
vim.keymap.set({ "n", "v" }, "<leader>f", function() require("conform").format() end, { noremap = true })
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

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
