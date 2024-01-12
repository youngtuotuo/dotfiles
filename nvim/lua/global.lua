-- stylua: ignore start
P = function(v) print(vim.inspect(v)) return v end

-- "none": No border (default).
-- "single": A single line box.
-- "double": A double line box.
-- "rounded": Like "single", but with rounded corners ("╭" etc.).
-- "solid": Adds padding by a single whitespace cell.
-- "shadow": A drop shadow effect by blending with the
--
-- BORDER = "none"
-- BORDER = { " ", " ", " ", " ", " ", " ", " ", " " }
BORDER = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

-- transparent control
TRANS = true
-- fk u MS
SEP = vim.fn.has("win32") == 1 and "\\" or "/"
HOME = vim.fn.has("win32") == 1 and "USERPROFILE" or "HOME"
EXT = vim.fn.has("win32") == 1 and ".exe" or ""
-- stylua: ignore end
