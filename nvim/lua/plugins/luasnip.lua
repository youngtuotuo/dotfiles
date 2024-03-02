return {
  "L3MON4D3/LuaSnip",
  cond = function()
    return vim.o.filetype ~= "TelescopPrompt" and vim.o.filetype ~= "help"
  end,
  ft = { "tex", "c", "lua", "python" },
  event = { "BufRead" },
  version = "v2.*",
  opts = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
      [require("luasnip.util.types").choiceNode] = {
			active = {
				virt_text = { { "●", "Orange" } },
			},
		},
    }
  },
  -- stylua: ignore
  keys = function()
    local next_node = function()
      if require("luasnip").jumpable(1) then
        require("luasnip").jump(1)
      end
    end
    local prev_node = function()
      if require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      end
    end
    local cycle_choice = function()
      if require("luasnip").choice_active() then
        require("luasnip").change_choice(1)
      end
    end
    return {
      {"<C-j>", next_node,    silent = true, mode = { "i", "s" }},
      {"<C-k>", prev_node,    silent = true, mode = { "i", "s" }},
      {"<C-l>", cycle_choice, silent = true, mode = { "i", "s" }},
    }
  end,
  config = function(_, opts)
    local ls = require("luasnip")
    local snippet_path = ""
    snippet_path = vim.fn.stdpath("config") .. "/lua/snippets/"
    require("luasnip.loaders.from_lua").load({ paths = snippet_path })
    vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])
    ls.config.set_config(opts)
  end,
}
