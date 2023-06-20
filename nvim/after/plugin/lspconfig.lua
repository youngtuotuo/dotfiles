local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then return end
require('lspconfig.ui.windows').default_options.border = BORDER
require("neodev").setup({})
require("mason").setup({ui = {border = BORDER}})
-- Ensure the servers above are installed
local servers = {
    "lua_ls", "clangd", "rust_analyzer", "texlab", "html", "pyright", "yamlls",
    "gopls"
}
require("mason-lspconfig").setup {ensure_installed = servers}

local diag_config = {
    virtual_text = false,
    signs = true,
    underline = false,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        source = "if_many",
        title = " σ`∀´)σ ",
        border = BORDER,
        max_width = 80
    },
    source = true
}

vim.diagnostic.config(diag_config)

local signs = {
    {name = "DiagnosticSignError", text = ""},
    {name = "DiagnosticSignWarn", text = ""},
    {name = "DiagnosticSignHint", text = ""},
    {name = "DiagnosticSignInfo", text = ""}
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name,
                       {texthl = sign.name, text = sign.text, numhl = ""})
end

require('nvim-custom-diagnostic-highlight').setup {
    patterns_override = {
        -- Lua patterns to be tested against the diagnostic message.
        -- Overrides default behavior
        '%sunused', '^unused', 'not used', 'never used', 'not read',
        'never read', 'empty block', 'not accessed'
    }
}

local util = require("lspconfig.util")

local on_attach = function(client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup('lsp_document_highlight', {clear = false})
        vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = 'lsp_document_highlight'
        })
        vim.api.nvim_create_autocmd({'CursorHold'}, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight
        })
        vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references
        })
    end

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings.
    local opts = {noremap = true, silent = false}
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa',
                   '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr',
                   '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl',
                   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                   opts)
    buf_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- buf_set_keymap('n', '<space>i', '<cmd>lua vim.lsp.buf.document_highlight()<CR>', opts)
    -- buf_set_keymap('n', '<space>ic', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
    -- buf_set_keymap('n', '<space>oc', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end


local hover = function(_, result, ctx, config)
    if not (result and result.contents) then
        return vim.lsp.handlers.hover(_, result, ctx, config)
    end
    if type(result.contents) == "string" then
        local s = string.gsub(result.contents or "", "&nbsp;", " ")
        s = string.gsub(s, [[\\\n]], [[\n]])
        result.contents = s
        return vim.lsp.handlers.hover(_, result, ctx, config)
    else
        local s = string.gsub((result.contents or {}).value or "", "&nbsp;", " ")
        s = string.gsub(s, "\\\n", "\n")
        result.contents.value = s
        return vim.lsp.handlers.hover(_, result, ctx, config)
    end
end

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(hover, {
        border = BORDER,
        title = " Hover ",
        max_width = 100,
        zindex = 500
    }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers
                                                      .signature_help, {
        border = BORDER,
        title = " Signature ",
        max_width = 100
    })
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason-lspconfig").setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        lspconfig[server_name].setup({
            on_attach = on_attach,
            handlers = handlers,
            capabilities = capabilities
        })
    end,
    -- Next, you can provide targeted overrides for specific servers.
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup {
            on_attach = on_attach,
            handlers = handlers,
            capabilities = capabilities,
            root_dir = util.root_pattern(unpack({
                ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml",
                "stylua.toml", "selene.toml", "selene.yml", ".git"
            })),
            settings = {
                Lua = {
                    runtime = {version = "Lua 5.1"},
                    diagnostics = {globals = {'vim', 'use'}},
                    completion = {callSnippet = "Both"},
                    workspace = {checkThirdParty = false},
                    semantic = {enable = false}
                }
            }
        }
    end,
    ["pyright"] = function()
        lspconfig.pyright.setup {
            on_attach = on_attach,
            handlers = handlers,
            capabilities = capabilities,
            root_dir = util.root_pattern(unpack({
                'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt',
                'Pipfile', 'pyrightconfig.json', 'pyvenv.cfg'
            })),
            settings = {
                pyright = {
                    -- Disables the “Organize Imports” command.
                    -- This is useful if you are using another extension that provides similar
                    -- functionality and you don’t want the two extensions to fight each other.
                    disableOrganizeImports = false
                },
                python = {
                    analysis = {
                        -- Level of logging for Output panel. The default value for this option is "Information".
                        -- ["Error", "Warning", "Information", or "Trace"]
                        logLevel = "Information",
                        -- Determines whether pyright offers auto-import completions.
                        autoImportCompletions = true,
                        -- Determines whether pyright automatically adds common search
                        -- paths like "src" if there are no execution environments defined in the config file.
                        autoSearchPaths = true,
                        -- Determines whether pyright analyzes (and reports errors for) all
                        -- files in the workspace, as indicated by the config file.
                        -- If this option is set to "openFilesOnly", pyright analyzes only open files.
                        -- ["openFilesOnly", "workspace"]
                        diagnosticMode = "workspace",
                        -- Path to directory containing custom type stub files.
                        -- stubPath = {},
                        -- Determines the default type-checking level used by pyright.
                        -- This can be overridden in the configuration file.
                        -- (Note: This setting used to be called "pyright.typeCheckingMode".
                        -- The old name is deprecated but is still currently honored.)
                        -- ["off", "basic", "strict"]
                        typeCheckingMode = "basic",
                        -- Determines whether pyright reads, parses and analyzes library code
                        -- to extract type information in the absence of type stub files.
                        -- Type information will typically be incomplete.
                        -- We recommend using type stubs where possible. The default value for this option is false.
                        useLibraryCodeForTypes = true
                    }
                }
            }
        }
    end,
    ['texlab'] = function()
        lspconfig.texlab.setup {
            on_attach = on_attach,
            handlers = handlers,
            capabilities = capabilities,
            settings = {
                texlab = {
                    rootDirectory = nil,
                    build = {
                        executable = 'latexmk',
                        args = {
                            '-xelatex', '-interaction=nonstopmode',
                            '-synctex=1', '%f'
                        },
                        -- executable = 'xelatex',
                        onSave = false,
                        forwardSearchAfter = false
                    },
                    auxDirectory = '.',
                    forwardSearch = {executable = nil, args = {}},
                    chktex = {onOpenAndSave = false, onEdit = false},
                    diagnosticsDelay = 300,
                    latexFormatter = 'latexindent',
                    latexindent = {
                        ['local'] = nil, -- local is a reserved keyword
                        modifyLineBreaks = false
                    },
                    bibtexFormatter = 'texlab',
                    formatterLineLength = 80
                }
            }
        }
    end
})

