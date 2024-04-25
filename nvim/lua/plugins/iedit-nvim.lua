return {
  "altermo/iedit.nvim",
  opts = {
    select = {
      map = {
        q = { "done" },
        ["<Esc>"] = { "select", "done" },
        ["<CR>"] = { "toggle" },
        n = { "toggle", "next" },
        p = { "toggle", "prev" },
        N = { "next" },
        P = { "prev" },
        a = { "all" },
        --Mapping to use while in selection-mode
        --Possible values are:
        -- • `done` Done with selection
        -- • `next` Go to next occurrence
        -- • `prev` Go to previous occurrence
        -- • `select` Select current
        -- • `unselect` Unselect current
        -- • `toggle` Toggle current
        -- • `all` Select all
      },
    },
  },
  config = function(_, opts)
    require("iedit").setup(opts)
    vim.keymap.set({ "n" }, "<leader>i", require("iedit").toggle, { noremap = true })
  end
}
