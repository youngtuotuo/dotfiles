-- some useful lua functions


-- print details
P = function(v)
  print(vim.inspect(v))
  return v
end

-- "none": No border (default).
-- "single": A single line box.
-- "double": A double line box.
-- "rounded": Like "single", but with rounded corners ("╭" etc.).
-- "solid": Adds padding by a single whitespace cell.
-- "shadow": A drop shadow effect by blending with the
-- BORDER = "none"
BORDER = {' ', ' ', ' ', ' ', ' ', ' ',' ', ' '}
-- transparent control
TRANS = true
-- choose colorscheme
COLORSCHEME = "lunaperche" -- "tokyonight", "kanagawa", "lunaperche", "habamax", "rose-pine"
if COLORSCHEME == "lunaperche" or COLORSCHEME == "habamax" then
  local code = "colorscheme " .. COLORSCHEME
  vim.cmd(code)
  require('lazyload.colorscheme')
end
