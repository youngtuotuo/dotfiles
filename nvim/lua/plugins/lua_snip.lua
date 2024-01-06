return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    config = function()
      local ls = require("luasnip")
      local s = ls.s -- snippet
      local i = ls.i -- insert node
      local t = ls.t -- text node

      local d = ls.dynamic_node
      local c = ls.choice_node
      local f = ls.function_node
      local sn = ls.snippet_node

      local home = "HOME"
      local sep = "/"
      local snippet_path = ""
      if vim.fn.has("win32") == 1 then
        home = "USERPROFILE"
        sep = "\\"
        snippet_path = os.getenv(home)
          .. sep
          .. "github"
          .. sep
          .. "dotfiles"
          .. sep
          .. "nvim"
          .. sep
          .. "snippets"
          .. sep
      else
        snippet_path = os.getenv(home) .. sep .. ".config/nvim/snippets/"
      end
      -- require("luasnip.loaders.from_vscode").lazy_load()
      P(snippet_path)
      require("luasnip.loaders.from_lua").load({ paths = snippet_path })
      ls.config.setup({ store_selection_keys = "<A-p>" })

      vim.cmd(
        [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]
      ) --}}}

      -- Virtual Text{{{
      local types = require("luasnip.util.types")
      ls.config.set_config({
        history = true, --keep around last snippet local to jump back
        updateevents = "TextChanged,TextChangedI", --update changes as you type
        enable_autosnippets = true,
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "●", "GruvboxOrange" } },
            },
          },
          -- [types.insertNode] = {
          -- 	active = {
          -- 		virt_text = { { "●", "GruvboxBlue" } },
          -- 	},
          -- },
        },
      }) --}}}

      -- Key Mapping --{{{
      vim.keymap.set(
        { "i", "s" },
        "<c-u>",
        '<cmd>lua require("luasnip.extras.select_choice")()<cr><C-c><C-c>'
      )

      vim.keymap.set({ "i", "s" }, "<a-p>", function()
        if ls.expand_or_jumpable() then
          ls.expand()
        end
      end, { silent = true })
      -- vim.keymap.set({ "i", "s" }, "<C-k>", function()
      -- 	if ls.expand_or_jumpable() then
      -- 		ls.expand_or_jump()
      -- 	end
      -- end, { silent = true })
      -- vim.keymap.set({ "i", "s" }, "<C-j>", function()
      -- 	if ls.jumpable() then
      -- 		ls.jump(-1)
      -- 	end
      -- end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<A-y>", "<Esc>o", { silent = true })

      vim.keymap.set({ "i", "s" }, "<a-k>", function()
        if ls.jumpable(1) then
          ls.jump(1)
        end
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<a-j>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<a-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        else
          -- print current time
          local t = os.date("*t")
          local time = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
          print(time)
        end
      end)
      vim.keymap.set({ "i", "s" }, "<a-h>", function()
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end) --}}}

      -- More Settings --

      vim.keymap.set("n", "<Leader><CR>", "<cmd>LuaSnipEdit<cr>", { silent = true, noremap = true })
      vim.cmd(
        [[autocmd BufEnter */snippets/*.lua nnoremap <silent> <buffer> <CR> /-- End Refactoring --<CR>O<Esc>O]]
      )
    end,
  },
}
