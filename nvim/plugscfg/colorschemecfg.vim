" onedark
let g:onedark_italic_comment = v:false 
let g:onedark_diagnostics_undercurl = v:true
let g:onedark_transparent_background = v:true
let g:onedark_hide_ending_tildes=v:false
let g:onedark_darker_diagnostics=v:true
let g:onedark_style = 'cool'
lua << EOF
    vim.g.onedark_toggle_style_keymap = '<leader>tc'
EOF
" colorscheme onedark
" sonokai
" 'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`, `'espresso'`
let g:sonokai_style = 'atlantis'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1
" colorscheme sonokai

" onedarkpro
" colorscheme onedarkpro
" onenord
lua << EOF
    require('onenord').setup({
      borders = true, -- Split window borders
      italics = {
        comments = false, -- Italic comments
        strings = false, -- Italic strings
        keywords = false, -- Italic keywords
        functions = false, -- Italic functions
        variables = false, -- Italic variables
      },
      disable = {
        background = false, -- Disable setting the background color
        cursorline = false, -- Disable the cursorline
        eob_lines = true, -- Hide the end-of-buffer lines
      },
      custom_highlights = {}, -- Overwrite default highlight groups
    })
EOF
colorscheme onenord
" github-colors
" colorscheme github-colors
" nord
let g:nord_contrast = v:true
let g:nord_borders = v:true
let g:nord_disable_background = v:false
let g:nord_italic = v:false
" colorscheme nord
