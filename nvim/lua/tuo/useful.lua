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
  if vim.fn.has("win32") == 1 then
    local ipconfig_command = io.popen("ipconfig")
    local output = ipconfig_command:read("*a")
    ipconfig_command:close()

    local lan_ip = output:match("IPv4 Address%s*:%s*([%d%.]+)")

    return lan_ip
  else
    local cmd = "ip route get 1.1.1.1 | awk '{print $7}'"
    local ip = vim.fn.system(cmd)
    return ip:gsub("%s+", "")  -- Remove any leading/trailing whitespace
  end
end
