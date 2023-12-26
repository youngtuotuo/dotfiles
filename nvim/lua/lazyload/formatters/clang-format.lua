return function()
  return {
    exe = "clang-format",
    args = { '--style="{BasedOnStyle: llvm, ColumnLimit: 100, IndentWidth: 4, AccessModifierOffset: -2, IndentCaseBlocks: true}"' },
    stdin = true,
  }
end
