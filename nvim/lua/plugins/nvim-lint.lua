return {
  {
    "mfussenegger/nvim-lint",
    ft = { "python" },
    config = function()
      require("lint").linters_by_ft = {
        python = { "ruff" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        group = _G.auG,
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
