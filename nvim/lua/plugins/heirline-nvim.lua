return {
  "rebelot/heirline.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim"
  },
  config = function(_, _)
    local get_colors = function()
      local utils = require("heirline.utils")
      return {
        red_fg = utils.get_highlight("GitSignsDelete").fg,
        green_fg = utils.get_highlight("GitSignsAdd").fg,
        yellow_fg = utils.get_highlight("GitsignsChange").fg,
        magenta_fg = utils.get_highlight("GitsignsChange").fg,
      }
    end
    local conditions = require("heirline.conditions")

    local Space = { provider = " " }
    local Align = { provider = "%=" }


    local Git = {
      init = function(self)
        -- gitsigns buffer changes
        self.status_dict = vim.b.gitsigns_status_dict
      end,
      condition = function(self)
        -- priotize gitsigns, otherwise try vim-fugitive
        self.head = vim.b.gitsigns_head
        if not self.head and vim.g.loaded_fugitive == 1 then
          self.head = vim.fn.FugitiveHead()
        end
        return type(self.head) == "string"
      end,
      {
        provider = function(self)
          local count = self.status_dict and self.status_dict.added or 0
          return count > 0 and ("+" .. count) .. " "
        end,
        hl = { fg = "green_fg" },
      },
      {
        provider = function(self)
          local count = self.status_dict and self.status_dict.removed or 0
          return count > 0 and ("-" .. count) .. " "
        end,
        hl = { fg = "red_fg" },
      },
      {
        provider = function(self)
          local count = self.status_dict and self.status_dict.changed or 0
          return count > 0 and ("~" .. count)
        end,
        hl = { fg = "yellow_fg" },
      },
    }

    local FileName = {
      -- flexible: shorten path if space doesn't allow for full path
      flexible = 2,
      init = function(self)
        -- make relative, see :h filename-modifers
        self.relname = vim.fn.fnamemodify(self.filename, ":.")
        if self.relname == "" then
          self.relname = "[No Name]"
        end
      end,
      {
        provider = function(self)
          return self.relname
        end,
      },
      {
        provider = function(self)
          return vim.fn.pathshorten(self.relname)
        end,
      },
      {
        provider = function(self)
          return vim.fn.fnamemodify(self.filename, ":t")
        end,
      },
    }

    local FileFlags = {
      {
        condition = function()
          return vim.bo.modified
        end,
        provider = " [+]",
        hl = { fg = "yellow_fg" },
      },
      {
        condition = function()
          return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = " ",
        hl = { fg = "orange" },
      },
    }

    local FileNameBlock = {
      update = { "BufEnter", "DirChanged", "BufModifiedSet", "VimResized" },
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
      end,
      FileName,
      FileFlags,
      { provider = "%<" }, -- cut here when there's not enough space
    }

    local FileType = {
      provider = function()
        return "[" .. vim.bo.filetype .. "]"
      end,
    }

    local Ruler = {
      -- %l = current line number
      -- %L = number of lines in the buffer
      -- %c = column number
      -- %P = percentage through file of displayed window
      provider = "%7l, %2c ",
    }

    local Diagnostics = {
      static = {
        error_icon = "E",
        warn_icon = "W",
        info_icon = "I",
        hint_icon = "H",
      },
      condition = function()
        return #vim.diagnostic.get(0) > 0
      end,
      init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      end,
      {
        provider = function(self)
          return self.errors > 0 and string.format(" %s:%s", self.error_icon, self.errors)
        end,
        hl = { fg = "red_fg", bold = true },
      },
      {
        provider = function(self)
          return self.warnings > 0 and string.format(" %s:%s", self.warn_icon, self.warnings)
        end,
        hl = { fg = "yellow_fg", bold = true },
      },
      {
        provider = function(self)
          return self.info > 0 and string.format(" %s:%s", self.info_icon, self.info)
        end,
        hl = { fg = "green_fg", bold = true },
      },
      {
        provider = function(self)
          return self.hints > 0 and string.format(" %s:%s", self.hint_icon, self.hints)
        end,
        hl = { fg = "magenta_fg", bold = true },
      },
    }

    local DefaultStatusLine = {
      FileNameBlock,
      Diagnostics,
      Align, -- Left
      Git,
      Space,
      Align, -- Middle
      Space,
      Ruler,
      FileType, -- Right
    }

    local InactiveStatusline = {
      condition = conditions.is_not_active,
      {
        init = function(self)
          self.filename = vim.api.nvim_buf_get_name(0)
        end,
        FileName,
      },
    }

    local HelpFileName = {
      condition = function()
        return vim.bo.filetype == "help"
      end,
      provider = function()
        local filename = vim.api.nvim_buf_get_name(0)
        return vim.fn.fnamemodify(filename, ":t")
      end,
    }

    local SpecialStatusline = {
      condition = function()
        return conditions.buffer_matches({
          buftype = { "nofile", "prompt", "help", "quickfix" },
          filetype = { "fzf", "^git.*", "fugitive", "fugitiveblame" },
        })
      end,
      Align,
      FileType,
      Space,
      HelpFileName,
      Align,
    }

    local TerminalName = {
      provider = function()
        local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
        return tname
      end,
      hl = { bold = true },
    }

    local TerminalStatusline = {
      condition = function()
        return conditions.buffer_matches({ buftype = { "terminal" } })
      end,
      { condition = conditions.is_active, Space },
      Align,
      TerminalName,
      Align,
    }

     local res = {
      hl = function()
        if conditions.is_active() then
          return "StatusLine"
        else
          return "StatusLineNC"
        end
      end,
      fallthrough = false,
      SpecialStatusline,
      TerminalStatusline,
      InactiveStatusline,
      DefaultStatusLine,
    }
    require("heirline").setup({
      opts = { colors = get_colors },
      statusline = res
    })
  end,
}
