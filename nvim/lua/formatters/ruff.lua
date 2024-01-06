return function()
  return {
    exe = "ruff",
    args = { "format", "--line-length", "150", "-q", "-" },
    stdin = true,
  }
end
