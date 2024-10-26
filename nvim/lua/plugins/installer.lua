-- overload default float win
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.max_width = _G.floatw
  opts.max_height = _G.floath
  opts.wrap = _G.floatwrap
  opts.border = "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local fts = { "python", "c", "cpp", "cuda" }

return {
  {
    "williamboman/mason.nvim",
    ft = fts,
    init = function()
      vim.api.nvim_create_user_command("M", "Mason", {})
    end,
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    -- Better installer than default
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = true,
    dependencies = "williamboman/mason.nvim",
    opts = function()
      return {
        ensure_installed = {
          "codelldb",
          "debugpy",
        },
      }
    end,
  },
}
