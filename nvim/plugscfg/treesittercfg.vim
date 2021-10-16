lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"bash", "c", "lua", "yaml", "python"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {"vim"}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {'vim', 'hover'},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    --additional_vim_regex_highlighting = true,
  },
  indent = {
      enable = true, -- experimental feature
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
