return {
  "b0o/incline.nvim",
  event = "BufRead",
  opts = {
    render = function(props)
      local bg = "NvimDarkGrey4"
      local text = {
        Error = { text = "error", fg = "NvimLightRed",    bg = bg },
        Warn  = { text = "warn",  fg = "NvimLightYellow", bg = bg },
        Info  = { text = "info",  fg = "NvimLightCyan",   bg = bg },
        Hint  = { text = "hint",  fg = "NvimLightBlue",   bg = bg },
      }

      local label = {}
      -- stylua: ignore
      for s, t in pairs(text) do
        local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(s)] })
        if n > 0 then
          table.insert(label, { string.format("%s %d ", t.text, n), guifg = t.fg, guibg = t.bg})
        end
      end
      return label
    end,
  },
}
