return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    cmd = "IBLToggle",
    opts = {
      enabled = false,
      scope = { enabled = true, show_start = false, show_end = false },
      indent = { char = "│" },
    },
  },
}
