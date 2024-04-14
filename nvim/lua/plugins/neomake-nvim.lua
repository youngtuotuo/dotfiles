return {
  "neomake/neomake",
  config = function()
    vim.g.neomake_open_list = 2
    vim.g.neomake_highlight_columns = 0
    vim.g.neomake_highlight_lines = 0
    vim.g.neomake_place_signs = 0
    vim.g.neomake_virtualtext_current_error = 0
    vim.g.neomake_ft_maker_remove_invalid_entries = 1
  end
}
