local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
  local watch_type = require("vim._watch").FileChangeType

  local function handler(res, callback)
    if not res.files or res.is_fresh_instance then
      return
    end

    for _, file in ipairs(res.files) do
      local path = res.root .. "/" .. file.name
      local change = watch_type.Changed
      if file.new then
        change = watch_type.Created
      end
      if not file.exists then
        change = watch_type.Deleted
      end
      callback(path, change)
    end
  end

  function watchman(path, opts, callback)
    vim.system({ "watchman", "watch", path }):wait()

    local buf = {}
    local sub = vim.system({
      "watchman",
      "-j",
      "--server-encoding=json",
      "-p",
    }, {
      stdin = vim.json.encode({
        "subscribe",
        path,
        "nvim:" .. path,
        {
          expression = { "anyof", { "type", "f" }, { "type", "d" } },
          fields = { "name", "exists", "new" },
        },
      }),
      stdout = function(_, data)
        if not data then
          return
        end
        for line in vim.gsplit(data, "\n", { plain = true, trimempty = true }) do
          table.insert(buf, line)
          if line == "}" then
            local res = vim.json.decode(table.concat(buf))
            handler(res, callback)
            buf = {}
          end
        end
      end,
      text = true,
    })

    return function()
      sub:kill("sigint")
    end
  end

  if vim.fn.executable("watchman") == 1 then
    wf._watchfunc = watchman
  else
    wf._watchfunc = function()
      return function() end
    end
  end
end

return {
  "neovim/nvim-lspconfig",
  init = function()
    vim.api.nvim_create_user_command("LI", "LspInfo", {})
  end,
  cmd = { "LspInfo" },
  ft = _G.lspfts,
  dependencies = {
    {
      "folke/neodev.nvim",
      cond = function()
        -- fk u MS
        return vim.fn.getcwd() == os.getenv(_G.home) .. string.format("%sgithub%sdotfiles", _G.sep, _G.sep)
      end,
      opts = {
        library = {
          runtime = true,
          plugins = { "nvim-dap-ui" },
          types = true,
        },
      },
    },
    {
      "williamboman/mason.nvim",
      cmd = { "Mason" },
      init = function()
        vim.api.nvim_create_user_command("M", "Mason", {})
      end,
      opts = {
        ui = { border = _G.border },
      },
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        handlers = {
          function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup({})
          end,
          ["lua_ls"] = require("language_servers.lua_ls"),
          ["pyright"] = require("language_servers.pyright"),
          ["ruff_lsp"] = require("language_servers.ruff_lsp"),
        },
      },
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = function()
        local ensure_installed = {
          "clang-format",
          "clangd",
          "debugpy",
          "gopls",
          "jq",
          "lua_ls",
          "pyright",
          "ruff",
          "ruff_lsp",
          "rust_analyzer",
          "shfmt",
          "stylua",
          "zls",
          "codelldb",
        }
        return {
          ensure_installed = ensure_installed,
        }
      end,
    },
  },
  config = function(_, _)
    -- LspInfo command
    require("lspconfig.ui.windows").default_options.border = _G.border
    -- all server agnostic settings
    for _, m in ipairs({
      "format",
      "capabilities",
      "keymaps",
      "diagnostics",
      "handlers",
      "floatwin",
    }) do
      require(string.format("language_servers.%s", m))
    end
  end,
}
