return {
  "RRethy/vim-illuminate",
  ft = _G.lspfts,
  opts = {
    modes_denylist = { "t" },
    filetypes_denylist = {},
    filetypes_allowlist = _G.lspfts,
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
    local next_ref = function()
      require("illuminate").goto_next_reference()
    end
    local prev_ref = function()
      require("illuminate").goto_prev_reference()
    end
    local ts_obj_status, ts_rep = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
    if ts_obj_status then
      next_ref, prev_ref = ts_rep.make_repeatable_move_pair(next_ref, prev_ref)
    end
    local keyms = {
      { "n", "<C-n>", next_ref, { desc = "Illuminate goto next reference" } },
      { "n", "<C-p>", prev_ref, { desc = "Illuminate goto previous reference" } },
    }
    for _, v in ipairs(keyms) do
      vim.keymap.set(unpack(v))
    end
    vim.api.nvim_del_augroup_by_name("vim_illuminate_autocmds")
  end,
}
