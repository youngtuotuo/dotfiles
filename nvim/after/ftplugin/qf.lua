-- Quickfix list
vim.api.nvim_create_user_command("Cnext", "try | cnext | catch | cfirst | catch | endtry", {})
vim.api.nvim_create_user_command("Cprev", "try | cprev | catch | clast | catch | endtry", {})
function Toggle_qf()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd("cclose")
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd("copen")
  end
end

local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }
-- ctrl-n, ctrl-p, you can hold alt
keymap("n", "co", "<cmd>lua Toggle_qf()<CR>", default_opts)
keymap("n", "<C-n>", "<cmd>Cnext<cr>zz", default_opts)
keymap("n", "<C-p>", "<cmd>Cprev<cr>zz", default_opts)

