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
      table.insert(label, { t .. " " .. n .. " ", guifg = his[s], guibg = bg})
    end
  end
  return label
end
return {
  "b0o/incline.nvim",
  opts = {
    render = function(props)
      local bufname = vim.api.nvim_buf_get_name(props.buf)
      local res = bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "[No Name]"
      local diagnostics = get_diagnostic_label(props)
      if vim.api.nvim_get_option_value("modified", { buf = props.buf }) then
        res = res .. " [+]"
      end

      local buffer = {
        { res, guibg = bg },
      }

      if #diagnostics > 0 then
        table.insert(diagnostics, { "| ", guibg = bg })
      end

      for _, buf in ipairs(buffer) do
        table.insert(diagnostics, buf)
      end
      return diagnostics
    end,
  },
}
