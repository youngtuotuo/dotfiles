lua << EOF
local theme = {
  normal = {
    a = {fg = 'white', bg = 'black', gui='reverse,bold'},
    b = {fg = 'white', bg = 'black', gui='reverse,bold'},
    c = {fg = 'white', bg = 'black', gui='reverse,bold'},
    x = {fg = 'white', bg = 'black', gui='reverse,bold'},
    y = {fg = 'white', bg = 'black', gui='reverse,bold'},
    z = {fg = 'white', bg = 'black', gui='reverse,bold'},
    },
  insert = { a = {fg = 'white', bg = 'black', gui='reverse,bold'} },
  visual = { a = {fg = 'white', bg = 'black', gui='reverse,bold'} },
  replace = { a = {fg = 'white', bg = 'black', gui='reverse,bold'} },
  inactive = {
    a = {fg = 'white', bg = 'black', gui='bold'},
    b = {fg = 'white', bg = 'black', gui='bold'},
    c = {fg = 'white', bg = 'black', gui='bold'},
    x = {fg = 'white', bg = 'black', gui='bold'},
    y = {fg = 'white', bg = 'black', gui='bold'},
    z = {fg = 'white', bg = 'black', gui='bold'},
    },
  }

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = theme,
    component_separators = {},
    section_separators = {},
    disabled_filetypes = {},
    always_divide_middle = true,
    },
  sections = {
    lualine_a = {'branch'},
    lualine_b = {{'filename', path=1}},
    lualine_c = {},
    lualine_x = {
      {'lsp_progress',
        display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
        separators = {
          component = ' ',
          progress = ' | ',
          message = { pre = '(', post = ')'},
          percentage = { pre = '', post = '%% ' },
          title = { pre = '', post = ': ' },
          lsp_client_name = { pre = '[', post = ']' },
          spinner = { pre = '', post = '' },
          message = { commenced = 'In Progress', completed = 'Completed' },
          },
        display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
        timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
        spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
        -- spinner_symbols = {"⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷"},
        }},
        lualine_y = {'progress'},
        lualine_z = {'location'},
        },
      inactive_sections = {
        lualine_a = {'branch'},
        lualine_b = {{'filename', path=1}},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {'progress'},
        lualine_z = {'location'},
        },
      tabline = {},
      extensions = {}
      }
EOF

