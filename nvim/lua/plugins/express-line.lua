-- https://github.com/ibhagwan/nvim-lua/blob/e30e10d900c7744e796bdfce47678244e70fe4f6/lua/plugins/statusline/init.lua
return {
  "tjdevries/express_line.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
  config = function()
    vim.opt.laststatus = 3
    local builtin = require("el.builtin")
    local extensions = require("el.extensions")
    local sections = require("el.sections")
    local subscribe = require("el.subscribe")
    local diagnostic = require("el.diagnostic")

    local function set_hl(hls, s)
      if not hls or not s then
        return s
      end
      hls = type(hls) == "string" and { hls } or hls
      for _, hl in ipairs(hls) do
        if vim.fn.hlID(hl) > 0 then
          return ("%%#%s#%s%%0*"):format(hl, s)
        end
      end
      return s
    end

    local git_changes_formatter = function(s)
      local specs = {
        insert = {
          regex = "%+(%d+)",
          icon = "+",
          hl = "diffAdded",
        },
        change = {
          regex = "%~(%d+)",
          icon = "~",
          hl = "diffChanged",
        },
        delete = {
          regex = "%-(%d+)",
          icon = "-",
          hl = "diffRemoved",
        },
      }
      local result = {}
      for k, v in pairs(specs) do
        local count = nil
        count = tonumber(string.match(s, v.regex))
        if count and count > 0 then
          table.insert(result, set_hl(v.hl, ("%s%d"):format(v.icon, count)))
        end
      end
      return table.concat(result, " ")
    end

    local git = subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
      local branch = extensions.git_branch(window, buffer)
      local changes = extensions.git_changes(window, buffer)
      res = ""
      if branch then
        res = res .. set_hl("@constant", "  " .. branch)
      end
      if changes then
        changes = git_changes_formatter(changes)
        res = res .. " " .. changes
      end
      return res
    end)

    local function diag_formatter(opts)
      return function(_, _, counts)
        local items = {}
        local icons = {
          ["errors"] = { opts.icon_err or "E", opts.hl_err },
          ["warnings"] = { opts.icon_warn or "W", opts.hl_warn },
          ["infos"] = { opts.icon_info or "I", opts.hl_info },
          ["hints"] = { opts.icon_hint or "H", opts.hl_hint },
        }
        for _, k in ipairs({ "errors", "warnings", "infos", "hints" }) do
          if counts[k] > 0 then
            table.insert(items, set_hl(icons[k][2], ("%s:%s"):format(icons[k][1], counts[k])))
          end
        end
        local fmt = opts.fmt or "%s"
        if vim.tbl_isempty(items) then
          return ""
        else
          if not vim.tbl_isempty(items) then
            contents = ("%s"):format(table.concat(items, " "))
          end
          return fmt:format(contents)
        end
      end
    end

    local get_buffer_counts = function(diagnostic, _, buffer)
      local counts = { 0, 0, 0, 0 }
      local diags = diagnostic.get(buffer.bufnr)
      if diags and not vim.tbl_isempty(diags) then
        for _, d in ipairs(diags) do
          if tonumber(d.severity) then
            counts[d.severity] = counts[d.severity] + 1
          end
        end
      end
      return {
        errors = counts[1],
        warnings = counts[2],
        infos = counts[3],
        hints = counts[4],
      }
    end

    local function wrap_fnc(opts, fn)
      return function(window, buffer)
        -- buf_autocmd doesn't send win
        if not window and buffer then
          window = { win_id = vim.fn.bufwinid(buffer.bufnr) }
        end
        if opts.hide_inactive and window and window.win_id ~= vim.api.nvim_get_current_win() then
          return ""
        end
        return fn(window, buffer)
      end
    end

    local diagnostics = function(opts)
      opts = opts or {}
      local formatter = opts.formatter or diag_formatter(opts)
      return subscribe.buf_autocmd(
        "el_buf_diagnostic",
        "DiagnosticChanged",
        wrap_fnc(opts, function(window, buffer)
          return formatter(window, buffer, get_buffer_counts(vim.diagnostic, window, buffer))
        end)
      )
    end

    local modes = {
      n = { "Normal", "N", { "@function" } },
      niI = { "Normal", "N", { "@function" } },
      niR = { "Normal", "N", { "@function" } },
      niV = { "Normal", "N", { "@functio" } },
      no = { "N·OpPd", "?", { "@function" } },
      v = { "Visual", "V", { "Directory" } },
      V = { "V·Line", "Vl", { "Directory" } },
      [""] = { "V·Blck", "Vb", { "Directory" } },
      s = { "Select", "S", { "Search" } },
      S = { "S·Line", "Sl", { "Search" } },
      [""] = { "S·Block", "Sb", { "Search" } },
      i = { "Insert", "I", { "@constant" } },
      ic = { "ICompl", "Ic" },
      R = { "Rplace", "R", { "WarningMsg", "IncSearch" } },
      Rv = { "VRplce", "Rv", { "WarningMsg", "IncSearch" } },
      c = { "Cmmand", "C", { "diffAdded", "DiffAdd" } },
      cv = { "Vim Ex", "E" },
      ce = { "Ex (r)", "E" },
      r = { "Prompt", "P" },
      rm = { "More  ", "M" },
      ["r?"] = { "Cnfirm", "Cn" },
      ["!"] = { "Shell ", "S", { "DiffAdd", "diffAdded" } },
      nt = { "Term  ", "T", { "Visual" } },
      t = { "Term  ", "T", { "DiffAdd", "diffAdded" } },
    }

    local mode = function(opts)
      opts = opts or {}
      return wrap_fnc(opts, function(_, _)
        local fmt = opts.fmt or "%s%s"
        local mode = vim.api.nvim_get_mode().mode
        local mode_data = opts.modes and opts.modes[mode]
        local hls = mode_data and mode_data[3]
        local icon = opts.hl_icon_only and set_hl(hls, opts.icon) or opts.icon
        mode = mode_data and mode_data[1]:upper() or mode
        mode = (fmt):format(icon or "", mode)
        return not opts.hl_icon_only and set_hl(hls, mode) or mode
      end)
    end

    require("el").setup({
      generator = function(window, buffer)
        local items = {
          { mode({ modes = modes, fmt = "%s %s ", icon = "", hl_icon_only = false }) },
          { sections.maximum_width(builtin.file_relative, 0.60), required = true },
          { sections.collapse_builtin({ { " " }, { builtin.modified_flag } }) },
          {
            diagnostics({
              fmt = " %s",
              hl_err = "DiagnosticError",
              hl_warn = "DiagnosticWarn",
              hl_info = "DiagnosticInfo",
              hl_hint = "DiagnosticHint",
            }),
          },
          { sections.split, required = true },
          { git },
          { " " },
          {
            sections.collapse_builtin({
              "[",
              builtin.help_list,
              builtin.readonly_list,
              "]",
            }),
          },
          { builtin.filetype },
        }

        local result = {}
        for _, item in ipairs(items) do
          table.insert(result, item)
        end

        return result
      end,
    })
  end,
}
