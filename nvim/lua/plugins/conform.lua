return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  lazy = true,
  cmd = "ConformInfo",
  -- stylua: ignore
  keys = {
    { "<leader>f", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, mode = { "n", "v" }, desc = "Format buffer" }
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  opts = {
    format = {
      timeout_ms = 3000,
      async = false, -- not recommended to change
      quiet = false, -- not recommended to change
    },
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_format" },
    },
    formatters = {
      stylua = {
        cmd = "stylua",
        prepend_args = {
          "--indent-type=spaces",
          "--indent-width=2",
          "--column-width=100",
        },
      },
      ruff_fmt = {
        prepend_args = { "--line-length", "150" },
      },
    },
  },
  config = function(_, opts)
    for _, key in ipairs({ "format_on_save", "format_after_save" }) do
      if opts[key] then
        opts[key] = nil
      end
    end
    require("conform").setup(opts)
  end,
}
