return {
  "mfussenegger/nvim-lint",
  lazy = true,
  ft = { "python" },
  dependencies = {
    "williamboman/mason.nvim"
  },
  config = function()
    -- require("lint").linters_by_ft = {
    --   python = { "ruff" },
    -- }
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      group = _G.group,
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
