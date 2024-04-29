return {
  "kevinhwang91/nvim-bqf",
  ft = { "qf" },
  opts = {
    preview = {
      should_preview_cb = function(bufnr, qwinid)
        local ret = true
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        local fsize = vim.fn.getfsize(bufname)
        if fsize > 100 * 1024 then
          -- skip file size greater than 100k
          ret = false
        elseif bufname:match("^fugitive://") then
          -- skip fugitive buffer
          ret = false
        end
        return ret
      end,
      winblend = vim.o.winblend,
      show_scroll_bar = false
    },
    auto_resize_height = true,
    filter = {
      fzf = {
        action_for = {
          ["ctrl-s"] = "split",
        },
      },
    },
  },
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
    {
      "junegunn/fzf",
    },
  },
}
