local M = {}

-- "none": No border (default).
-- "single": A single line box.
-- "double": A double line box.
-- "rounded": Like "single", but with rounded corners ("╭" etc.).
-- "solid": Adds padding by a single whitespace cell.
-- "shadow": A drop shadow effect by blending with the
-- BORDER = "none"
-- M.border = { " ", " ", " ", " ", " ", " ", " ", " " }
M.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
-- transparent control
M.trans = false

return M
