return {
  "RRethy/vim-illuminate",
  opts = {
    modes_denylist = { "t" },
    filetypes_denylist = {
      "dirbuf",
      "dirvish",
      "fugitive",
      "help",
      "markdown",
    },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
    local ts_obj_status, ts_rep = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
    local next_ref = function() require("illuminate").goto_next_reference(); vim.cmd[[norm zz]] end
    local prev_ref = function() require("illuminate").goto_prev_reference(); vim.cmd[[norm zz]] end
    if ts_obj_status then
      next_ref, prev_ref = ts_rep.make_repeatable_move_pair(next_ref, prev_ref)
    end
    local keyms = {
      { "n", "<C-n>", function() next_ref() end, { desc = "Illuminate goto next reference" } },
      { "n", "<C-p>", function() prev_ref() end, { desc = "Illuminate goto previous reference" } },
    }
    for _, v in ipairs(keyms) do
      vim.keymap.set(unpack(v))
    end
    vim.api.nvim_del_augroup_by_name("vim_illuminate_autocmds")
  end,
}
