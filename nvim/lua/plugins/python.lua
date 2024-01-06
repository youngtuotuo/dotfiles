return {
  {
    "Vimjas/vim-python-pep8-indent",
    ft = { "python" },
  },
  {
    "microsoft/python-type-stubs",
    ft = { "python" },
    event = "LspAttach",
    cond = false
  },
}
