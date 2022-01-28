lua << EOF
local border = {
    {"+", "FloatBorder"},
    {"-", "FloatBorder"},
    {"+", "FloatBorder"},
    {"|", "FloatBorder"},
    {"+", "FloatBorder"},
    {"-", "FloatBorder"},
    {"+", "FloatBorder"},
    {"|", "FloatBorder"},
}

local signature_cfg = {
  debug = false, -- set to true to enable debug logging
  log_path = "debug_log_file_path", -- debug log path
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
             -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 0, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
               -- set to 0 if you DO NOT want any API comments be shown
               -- This setting only take effect in insert mode, it does not affect signature help in normal
               -- mode, 10 by default

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = " ",  -- Panda for parameter🐼
  hint_scheme = "String",
  use_lspsaga = false,  -- set to true if you want to use lspsaga popup
  hi_parameter = "IncSearch", --"LspSignatureActiveParameter", -- how your parameter will be highlight
  max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
                 -- to view the hiding contents
  max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  handler_opts = {
  border = border   -- double, rounded, single, shadow, none
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = '<C-x>' -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}

require "lsp_signature".setup(signature_cfg)

local orig_open_float = vim.diagnostic.open_float
function vim.diagnostic.open_float(bufnr, opts)
  opts = opts or {}
  opts = {
    scope = "line",
    max_height = 12,
    max_width = 80,
    border = border,
    severity_sort = true,
    source = "always",
  }
  opts.border = opts.border or border
  return orig_open_float(bufnr, opts)
end
-- vim.api.nvim_command [[autocmd CursorHold  * lua vim.lsp.buf.document_highlight()]]
vim.api.nvim_command [[autocmd CursorMoved * lua vim.lsp.buf.clear_references()]]
local protocol = require'vim.lsp.protocol'
protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local custom_on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=false }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>i', '<cmd>lua vim.lsp.buf.document_highlight()<CR>', opts)
  --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- diagnostic after each line
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    severity_sort = true,
    underline = true,
    virtual_text = {
        prefix='',
    },
    signs = false,
    update_in_insert=false,
    --virtual_text = {
    --  source = "if_many",
    --  format=function(diagnostic)
    --      if diagnostic.severity == vim.diagnostic.severity.ERROR then
    --          return "E" --" "
    --      end
    --      if diagnostic.severity == vim.diagnostic.severity.WARN then
    --          return "W" --" "
    --      end
    --      if diagnostic.severity == vim.diagnostic.severity.HINT then
    --          return "H" --" "
    --      end
    --      if diagnostic.severity == vim.diagnostic.severity.INFO then
    --          return "I" --" "
    --      end
    --  end,
    --  prefix='',
    --  spacing=0,
    --},
    float = {
      source = "always"
    },
  }
)

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Code actions
capabilities.textDocument.codeAction = {
  dynamicRegistration = false;
      codeActionLiteralSupport = {
          codeActionKind = {
              valueSet = {
                 "",
                 "quickfix",
                 "refactor",
                 "refactor.extract",
                 "refactor.inline",
                 "refactor.rewrite",
                 "source",
                 "source.organizeImports",
              };
          };
      };
}

-- Snippets
capabilities.textDocument.completion.completionItem.snippetSupport = true;
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local nvim_lsp = require('lspconfig')
local servers = { 'pyright', 'vimls', 'bashls', 'yamlls', 'diagnosticls' }
local handlers = {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border, max_width=80}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border, max_width=80}),
}
-- 'cmake', 'diagnosticls', 'dockerls'
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    handlers = handlers,
    on_attach = custom_on_attach,
    init_options = {
        onlyAnalyzeProjectsWithOpenFiles = false,
        suggestFromUnimportedLibraries = true,
        closingLabels = true,
    };
    flags = {
      debounce_text_changes = 150,
    }
  }
end
nvim_lsp.ccls.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = custom_on_attach,
  flags = {
    debounce_text_changes = 150,
  };
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = false,
    suggestFromUnimportedLibraries = true,
    closingLabels = true,
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
    cache = {
      directory = ".ccls-cache";
    };
  } ;
}
EOF
