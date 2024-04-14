return {
  "romainl/vim-qf",
  config = function()
    vim.keymap.set({ "n" }, "cp", "<Plug>(qf_qf_previous)", { nowait = true, noremap = true, desc = "cprev" })
    vim.keymap.set({ "n" }, "cn", "<Plug>(qf_qf_next)", { nowait = true, noremap = true, desc = "cnext" })
    vim.keymap.set({ "n" }, "co", function()
      local windows = vim.fn.getwininfo()
      for _, win in pairs(windows) do
        if win["quickfix"] == 1 and win["loclist"] == 0 then
          vim.cmd.cclose()
          return
        end
      end
      vim.cmd.copen()
    end, { nowait = true, noremap = true, desc = "toggle quickfix window" })
    vim.keymap.set({ "n" }, "[l", "<Plug>(qf_loc_previous)", { nowait = true, noremap = true, desc = "lprev" })
    vim.keymap.set({ "n" }, "]l", "<Plug>(qf_loc_next)", { nowait = true, noremap = true, desc = "lnext" })
    vim.keymap.set({ "n" }, "<leader>l", function()
      local windows = vim.fn.getwininfo()
      for _, win in pairs(windows) do
        if win["quickfix"] == 1 and win["loclist"] == 1 then
          vim.cmd.lclose()
          return
        end
      end
      vim.cmd.lopen()
    end, { nowait = true, noremap = true, desc = "lopen" })
    vim.g.qf_mapping_ack_style = 1
    vim.g.qf_auto_resize = 1
    vim.g.qf_max_height = 20
    vim.g.qf_auto_quit = 0
  end,
}
