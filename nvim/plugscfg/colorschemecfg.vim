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
" nord
let g:nord_contrast = v:true
let g:nord_borders = v:true
let g:nord_disable_background = v:false
let g:nord_italic = v:false

colorscheme onenord
" colorscheme nord
" colorscheme onedark
" colorscheme onedarkpro
" colorscheme sonokai
