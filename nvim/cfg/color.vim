lua << EOF
  require('colorizer').setup()
  require('onedark').setup({
    highlights = {
      Normal = {bg='$black'},
      EndOfBuffer = {bg='$black'},
      SignColumn = {bg='$black'},
      StatusLine = {fg='$black', bg='white', fmt='bold'}
      
    },
    code_style = {
        comments = 'none',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },
  })
  require('onedark').load()
EOF

