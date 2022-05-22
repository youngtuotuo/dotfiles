lua << EOF
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
      builtin.line,
      -- " : ",
      ", ",
      builtin.column,
      -- "]",
      " ",
      sections.collapse_builtin {
        "[",
        builtin.help_list,
        builtin.readonly_list,
        "]",
      },
      builtin.filetype,
    }
  end
  require('el').setup { generator = generator }
EOF
" hi LineNr      guifg=yellow  
" hi LineNrAbove guifg=Gray
" hi LineNrBelow guifg=Gray
" hi NormalFloat guibg=#282c34
hi VertSplit cterm=reverse ctermfg=NONE ctermbg=NONE
hi NormalFloat cterm=NONE ctermbg=DarkGray
hi FloatBorder cterm=NONE ctermbg=DarkGray
" hi Type gui=NONE
hi StatusLine cterm=NONE ctermfg=LightGray ctermbg=NONE guifg=LightGray guibg=NONE
hi StatusLineNC cterm=NONE ctermfg=White ctermbg=NONE guibg=white guifg=black
" hi Normal guibg=black
" hi SignColumn guibg=black
" hi EndOfBuffer guibg=black
hi Pmenu cterm=NONE ctermfg=Black ctermbg=DarkGray
hi PmenuSel ctermfg=Black ctermbg=Gray guifg=Black guibg=DarkGray
