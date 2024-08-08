return {
  "ej-shafran/compile-mode.nvim",
  branch = "latest",
  -- or a specific version:
  -- tag = "v3.0.0"
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- if you want to enable coloring of ANSI escape codes in
    -- compilation output, add:
    { "m00qek/baleia.nvim", tag = "v1.3.0" },
  },
  opts = {},
}
