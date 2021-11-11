lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "bash", "c", "lua", "yaml", "python" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    --additional_vim_regex_highlighting = true,
  },
  indent = {
      enable = false, -- experimental feature
      disable = {},
  },  
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}
require("nvim-gps").setup({
    icons = {
      ["class-name"] = ' ',      -- Classes and class-like objects
      ["function-name"] = ' ',   -- Functions
      ["method-name"] = ' ',     -- Methods (functions inside class-like objects)
      ["container-name"] = ' ',  -- Containers (example: lua tables)
      ["tag-name"] = '炙'         -- Tags (example: html tags)
    },
    -- Add custom configuration per language or
    -- Disable the plugin for a language
    -- Any language not disabled here is enabled by default
    languages = {
        -- ["bash"] = false, -- disables nvim-gps for bash
        -- ["go"] = false,   -- disables nvim-gps for golang
        -- ["ruby"] = {
        --	separator = '|', -- Overrides default separator with '|'
        --	icons = {
        --		-- Default icons not specified in the lang config
        --		-- will fallback to the default value
        --		-- "container-name" will fallback to default because it's not set
        --		["function-name"] = '',    -- to ensure empty values, set an empty string
        --		["tag-name"] = ''
        --		["class-name"] = '::',
        --		["method-name"] = '#',
        --	}
        --}
    },
    separator = '  ',
    -- limit for amount of context shown
    -- 0 means no limit
    -- Note: to make use of depth feature properly, make sure your separator isn't something that can appear
    -- in context names (eg: function names, class names, etc)
    depth = 0,
    -- indicator used when context is hits depth limit
    depth_limit_indicator = ".."
})
require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    throttle = true, -- Throttles plugin updates (may improve performance)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            -- 'for', -- These won't appear in the context
            -- 'while',
            -- 'if',
            -- 'switch',
            -- 'case',
        },
        -- Example for a specific filetype.
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        --   rust = {
        --       'impl_item',
        --   },
    },
}
-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
--require('nvim-treesitter.configs').setup {
--  highlight = {
--    enable = true, -- false will disable the whole extension
--  },
--  incremental_selection = {
--    enable = true,
--    keymaps = {
--      init_selection = 'gnn',
--      node_incremental = 'grn',
--      scope_incremental = 'grc',
--      node_decremental = 'grm',
--    },
--  },
--  indent = {
--    enable = true,
--  },
--  textobjects = {
--    select = {
--      enable = true,
--      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--      keymaps = {
--        -- You can use the capture groups defined in textobjects.scm
--        ['af'] = '@function.outer',
--        ['if'] = '@function.inner',
--        ['ac'] = '@class.outer',
--        ['ic'] = '@class.inner',
--      },
--    },
--    move = {
--      enable = true,
--      set_jumps = true, -- whether to set jumps in the jumplist
--      goto_next_start = {
--        [']m'] = '@function.outer',
--        [']]'] = '@class.outer',
--      },
--      goto_next_end = {
--        [']M'] = '@function.outer',
--        [']['] = '@class.outer',
--      },
--      goto_previous_start = {
--        ['[m'] = '@function.outer',
--        ['[['] = '@class.outer',
--      },
--      goto_previous_end = {
--        ['[M'] = '@function.outer',
--        ['[]'] = '@class.outer',
--      },
--    },
--  },
--}
EOF
