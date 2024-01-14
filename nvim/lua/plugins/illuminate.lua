return {
  "RRethy/vim-illuminate",
  event = "LspAttach",
  -- stylua: ignore
  keys = {
    { "<c-p>", function() require("illuminate").goto_prev_reference() end, { desc = "go to previous reference" } },
    { "<c-n>", function() require("illuminate").goto_next_reference() end, { desc = "go to next reference" } },
  },
  opts = {
    providers = {
      "lsp",
      "treesitter",
    },
    filetypes_denylist = {
      "netrw",
      "TelescopeResults",
      "query",
      "gitrebase",
      "gitcommit",
      "lazy",
      "markdown",
      "mason",
      "text",
      "dashboard",
      "alpha",
      "undotree",
      "diff",
      "fugitive",
      "fugitiveblame",
      "Outline",
      "packer",
      "TelescopePrompt",
      "help",
      "telescope",
      "lspinfo",
      "Trouble",
      "quickfix",
      "fzf",
      "terminal",
      "console",
      "term://*",
      "Term://*",
      "qf",
      "prompt",
      "",
    },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = false })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite",{ underline = false })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = false })
  end,
}
