local detail = true
return {
  "stevearc/oil.nvim",
  opts = {
    columns = {
      "permissions",
      "size",
      "mtime",
    },
    keymaps = {
      ["gd"] = {
        desc = "Toggle file detail view",
        callback = function()
          detail = not detail
          if detail then
            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
          else
            require("oil").set_columns({ "icon" })
          end
        end,
      },
      ["."] = {
        "actions.open_cmdline",
        opts = {
          shorten_path = true,
        },
        desc = "Open vim cmdline with current entry as an argument",
      },
      ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
      ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
      ["yp"] = {
        function()
          local current_dir = require("oil").get_current_dir()
          local entry = require("oil").get_cursor_entry()["name"]
          vim.fn.setreg('"', current_dir .. entry)
          vim.notify("Yank " .. current_dir .. entry)
        end,
        mode = "n",
        nowait = true,
        desc = "Yank cursor entry full path.",
      },
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function(_, opts)
    require("oil").setup(opts)
    require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
  end,
}
