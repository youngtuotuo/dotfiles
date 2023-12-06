return function()
  return {
    exe = "ruff",
    args = { "format", "-q", "-" },
    stdin = true,
  }
end
