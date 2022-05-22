lua << EOF
  -- require('colorizer').setup()
  -- require('colorbuddy').colorscheme('gruvbuddy')
  require("stabilize").setup()
  -- And then when you're all done, just call
  local extensions = require('el.extensions')
  local subscribe = require('el.subscribe')
  local sections = require("el.sections")
  local builtin = require("el.builtin")
  local generator = function()
    return {
      -- extensions.mode,
      sections.split,
      -- subscribe.buf_autocmd(
      --   "el_file_icon",
      --   "BufRead",
      --   function(_, buffer)
      --     return extensions.file_icon(_, buffer)
      -- end),
      -- " ",
      builtin.file,
      sections.collapse_builtin {
        " ",
        builtin.modified_flag,
      },
      sections.split,
      subscribe.buf_autocmd("el_git_status", "BufWritePost", function(window, buffer)
        return extensions.git_changes(window, buffer)
      end),
      -- "[",
      -- builtin.line,
      -- " : ",
      -- builtin.column,
      -- "]",
      sections.collapse_builtin {
        "[",
        builtin.help_list,
        builtin.readonly_list,
        "]",
      },
      -- builtin.filetype,
    }
  end
  require('el').setup { generator = generator }
EOF
" hi LineNr      guifg=yellow  
" hi LineNrAbove guifg=Gray
" hi LineNrBelow guifg=Gray
" hi NormalFloat guibg=#282c34
" hi VertSplit gui=NONE guifg=LightGray guibg=LightGray
" hi Type gui=NONE
" hi StatusLine guifg=LightGray guibg=NONE
" hi Normal guibg=black
" hi SignColumn guibg=black
" hi EndOfBuffer guibg=black
" hi StatusLineNC guibg=white guifg=black
hi Pmenu ctermbg=Gray
hi PmenuSel guifg=Black guibg=LightGray
