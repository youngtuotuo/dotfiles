return {
  "mfussenegger/nvim-lint",
  ft = { "python" },
  dependencies = {
    "neovim/nvim-lspconfig"
  },
  config = function()
    require("lint").linters_by_ft = {
      python = { "ruff" },
    }
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost", "TextChanged" }, {
      group = _G.auG,
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
