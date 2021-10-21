lua << EOF
  require'nvim-web-devicons'.setup {
    -- your personnal icons can go here (to override)
    -- DevIcon will be appended to `name`
    override = {
      zsh = {
      icon = "",
      color = "#428850",
      name = "Zsh"
      }
    };
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
      default = true;
    }
EOF
