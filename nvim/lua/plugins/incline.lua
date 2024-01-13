local bg = "NvimDarkGrey3"
local function get_diagnostic_label(props)
  local text = {
    Error = "error",
    Warn  = "warn",
    Info  = "info",
    Hint  = "hint",
    Ok    = "ok",
  }
  local his = {
    Error = "NvimLightRed",
    Warn  = "NvimLightYellow",
    Info  = "NvimLightCyan",
    Hint  = "NvimLightBlue",
    Ok    = "NvimLightGreen"
  }

  local label = {}
  -- stylua: ignore
  for s, t in pairs(text) do
    local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(s)] })
    if n > 0 then
      table.insert(label, { string.format("%s %d ", t, n), guifg = his[s], guibg = bg})
    end
  end
  return label
end
return {
  "b0o/incline.nvim",
  opts = {
    render = function(props)
      local diagnostics = get_diagnostic_label(props)

      return diagnostics
    end,
  },
}
