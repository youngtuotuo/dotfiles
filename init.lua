vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.hlsearch = true
vim.opt.wrap = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.signcolumn = "yes:1"
vim.opt.inccommand = "split"
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

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Highlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 150 }
  end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("python", { clear = true }),
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

-- vim.lsp.config["basedpyright"] = {
--     cmd = { 'basedpyright-langserver', '--stdio' },
--     filetypes = { "python" },
--     root_markers = { "pyproject.toml" },
--     handlers = {
--         ["textDocument/publishDiagnostics"] = function() end,
--     },
--     on_attach = function(client, bufnr)
--       client.server_capabilities.semanticTokensProvider = nil
--     end,
--     settings = {
--         basedpyright = {
--             disableOrganizeImports = false,
--             analysis = {
--                 autoImportCompletions = true,
--                 autoSearchPaths = true,
--                 typeCheckingMode = "off",
--             }
--         }
--     },
--     offset_encoding = "utf-8"
-- }
-- vim.lsp.enable("basedpyright")

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

vim.diagnostic.config({ underline = false, virtual_lines = true })

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

local function clone_paq()
    local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
    local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
    if not is_installed then
      vim.fn.system { "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path }
      return true
    end
end

local function bootstrap_paq(packages)
    local first_install = clone_paq()
    vim.cmd.packadd("paq-nvim")
    local paq = require("paq")
    if first_install then
      vim.notify("Installing plugins... If prompted, hit Enter to continue.")
    end

    -- Read and install packages
    paq(packages)
    paq.install()
end

-- Call helper function
bootstrap_paq {
    "savq/paq-nvim",
    "junegunn/vim-easy-align",
    "tpope/vim-fugitive",
    "tpope/vim-eunuch",
    "tpope/vim-rsi",
    "tpope/vim-vinegar",
    "tpope/vim-characterize",
    "kylechui/nvim-surround",
    "easymotion/vim-easymotion",
    "ku1ik/vim-pasta",
    "numToStr/Comment.nvim",
    "stevearc/conform.nvim",
    "Wansmer/treesj",
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "czheo/mojo.vim", opt = true },
    { "iamcco/markdown-preview.nvim", build  = vim.fn['mkdp#util#install'] },
    { "junegunn/fzf",  build = vim.fn['fzf#install'] },
}

require("nvim-surround").setup()
require("Comment").setup()
vim.g.mkdp_open_to_the_world = 1
vim.g.mkdp_echo_preview_url = 1
vim.g.mkdp_port = '8088'
vim.g.fzf_layout = { down = "40%" }
require("conform").setup( { formatters_by_ft = { python = { "ruff_format" } } })
vim.keymap.set({ "n", "v" }, "<leader>f", function() require("conform").format() end, { noremap = true })
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("mojo", { clear = true }),
    pattern = "mojo",
    command = "packadd! mojo.vim"
})

vim.keymap.set({ "n" }, "gj", function() require("treesj").toggle() end, { noremap = true })
