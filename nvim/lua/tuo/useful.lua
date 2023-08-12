-- some useful lua functions
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
BORDER = "single"
TRANS = true
COLORSCHEME = "tokyonight" -- "tokyonight", "kanagawa"

GET_LAN_IP = function()
    local cmd = "ip route get 1.1.1.1 | awk '{print $7}'"
    local ip = vim.fn.system(cmd)
    return ip:gsub("%s+", "")  -- Remove any leading/trailing whitespace
end
