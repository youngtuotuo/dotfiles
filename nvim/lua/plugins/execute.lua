return {
  "ej-shafran/compile-mode.nvim",
  keys = {
    { "<M-c>", ":Compile ", mode = { "n" }, nowait = true, noremap = true }
  },
  branch = "latest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "m00qek/baleia.nvim", tag = "v1.3.0" },
  },
  config = function()
    ---@type CompileModeOpts
    vim.g.compile_mode = {
      baleia_setup = true
    }
  end
}
