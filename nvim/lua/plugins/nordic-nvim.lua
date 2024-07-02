return {
  "AlexvZyl/nordic.nvim",
  config = function(_, _)
    local palette = require("nordic.colors")
    require("nordic").setup({
      -- Enable bold keywords.
      bold_keywords = true,
      -- Enable italic comments.
      italic_comments = true,
      -- Enable general editor background transparency.
      transparent_bg = true,
      -- Enable brighter float border.
      bright_border = true,
      -- Reduce the overall amount of blue in the theme (diverges from base Nord).
      reduced_blue = true,
      telescope = {
        -- Available styles: `classic`, `flat`.
        style = "classic",
      },
      override = {
        StatusLine = {
          fg = palette.white1,
        },
      },
    })
    require("nordic").load()
  end,
}
