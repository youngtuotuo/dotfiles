lua << EOF
--vim.g.tokyonight_style = "night" -- "storm", "night", "day"
----Configure the colors used when opening a :terminal in Neovim
--vim.g.tokyonight_terminal_colors = true
--vim.g.tokyonight_italic_comments = false
--vim.g.tokyonight_italic_keywords = false
--vim.g.tokyonight_italic_functions = false
--vim.g.tokyonight_italic_variables = false
--vim.g.tokyonight_transparent = false
---- Adjusts the brightness of the colors of the Day style. Number between 0 and 1, from dull to vibrant colors
--vim.g.tokyonight_day_brightness = 0.3
---- Float windows like the lsp diagnostics windows get a darker background.
--vim.g.tokyonight_dark_float = true
---- Sidebar like windows like NvimTree get a darker background
--vim.g.tokyonight_dark_sidebar = true
---- Sidebar like windows like NvimTree get a transparent background
--vim.g.tokyonight_transparent_sidebar = false
--vim.g.tokyonight_hide_inactive_statusline = false
---- Set a darker background on sidebar-like windows. For example: ["qf", "vista_kind", "terminal", "packer"]
--vim.g.tokyonight_sidebars = { "qf", "terminal"}
--vim.cmd[[colorscheme tokyonight]]
--vim.cmd[[colorscheme OceanicNext]]
-- nightfox, duskfox, dawnfox, dayfox, nordfox, 
--require('nightfox').load("dayfox")
--require('onenord').setup({
--  theme = "dark", -- "light"
--  borders = true, -- Split window borders
--  italics = {
--    comments = false, -- Italic comments
--    strings = false, -- Italic strings
--    keywords = false, -- Italic keywords
--    functions = false, -- Italic functions
--    variables = false, -- Italic variables
--  },
--  disable = {
--    background = false, -- Disable setting the background color
--    cursorline = false, -- Disable the cursorline
--    eob_lines = false, -- Hide the end-of-buffer lines
--  },
--  custom_highlights = {}, -- Overwrite default highlight groups
--})
--require("github-theme").setup({
--  theme_style = "dark", -- dark, dark_default, dimmed, light, light_default
--  comment_style = "NONE", 
--  keyword_style = "NONE",
--  function_style = "NONE",
--  variable_style = "NONE",
--  msg_area_style = "NONE",
--  transparent = false,
--  hide_end_of_buffer = false,
--  hide_inactive_statusline = false,
--  sidebars = {"qf", "terminal"}, --{"qf", "vista_kind", "terminal", "packer"},
--  dark_sidebar = true,
--  dark_float =  true,                                                     
--  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
--  --colors = {hint = "orange", error = "#ff0000"}
--})
--vim.g.nord_contrast = true
--vim.g.nord_borders = true
--vim.g.nord_disable_background = false
--vim.g.nord_cursorline_transparent = false
--vim.g.nord_enable_sidebar_background = true
--vim.g.nord_italic = false
--require('nord').set()
--vim.g.vscode_style = "dark"
--vim.g.vscode_italic_comment = 0
--vim.cmd[[colorscheme vscode]]
EOF
" default, atlantis, andromeda, shusia, maia, espresso, 
" let g:sonokai_style = 'espresso'
" let g:sonokai_enable_italic = 0
" let g:sonokai_disable_italic_comment = 1
" colorscheme sonokai
" colorscheme darkblue
" colorscheme melange
set background=dark " or light if you want light mode
colorscheme gruvbox
