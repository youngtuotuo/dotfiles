return {
  "mfussenegger/nvim-lint",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  ft = { "markdown" },
  config = function(_, _)
    require("lint").linters_by_ft = {
      markdown = { "markdownlint" },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      group = "TuoGroup",
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
