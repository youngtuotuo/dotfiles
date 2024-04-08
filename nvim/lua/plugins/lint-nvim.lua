return {
  "mfussenegger/nvim-lint",
  ft = { "python" },
  dependencies = {
    "williamboman/mason.nvim"
  },
  config = function()
    require("lint").linters_by_ft = {
      python = { "ruff" },
    }
    local lint = false
    local toggle_lint = function()
      if lint == true then
        lint = false
        vim.diagnostic.reset(nil, 0)
      else
        lint = true
        require("lint").try_lint()
      end
    end
    vim.keymap.set({ "n" }, "<M-p>", toggle_lint, { noremap = true, desc = "Lint"})
  end,
}
