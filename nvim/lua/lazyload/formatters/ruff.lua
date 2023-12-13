return function()
  return {
    exe = "ruff",
    args = { "format", "--line-length", "100", "-q", "-" },
    stdin = true,
  }
end
