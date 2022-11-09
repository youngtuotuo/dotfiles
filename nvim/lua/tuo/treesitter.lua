r0eturn {
  ensure_installed = {
    "markdown", "bash", "c", "cpp", "lua", "toml", "yaml", "python",
    "vim", "rust", "go", "latex"
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  indent = {enable = false},
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "latex", 'markdown' },
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  textobjects = {
    enable = true,
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner'
      }
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {[']m'] = '@function.outer', [']]'] = '@class.outer'},
      goto_next_end = {[']M'] = '@function.outer', [']['] = '@class.outer'},
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer'
      },
      goto_previous_end = {['[M'] = '@function.outer', ['[]'] = '@class.outer'}
    }
  }
}
