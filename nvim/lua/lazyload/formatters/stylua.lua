local util = require("formatter.util")
return function()
  return {
    exe = "stylua",
    args = {
      "--indent-type=spaces",
      "--indent-width=2",
      "--column-width=100",
      "--search-parent-directories",
      "--stdin-filepath",
      util.escape_path(util.get_current_buffer_file_path()),
      "--",
      "-",
    },
    stdin = true,
  }
end
