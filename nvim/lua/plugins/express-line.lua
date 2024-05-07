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

    local get_icon = subscribe.buf_autocmd("el_file_icon", "BufEnter", function(_, bufnr)
      local icon = extensions.file_icon(_, bufnr)
      local _, color = require("nvim-web-devicons").get_icon_color(bufnr.name, bufnr.extension)
      vim.api.nvim_set_hl(0, "FileIcon", { fg = color })
      if icon then
        return set_hl("FileIcon", icon) .. " "
      end

      return ""
    end)

    local git_branch = subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
      local branch = extensions.git_branch(window, buffer)
      if branch then
        return set_hl("@constant", "  " .. branch)
      end
    end)

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

    local git_changes = subscribe.buf_autocmd("el_git_changes", "BufWritePost", function(window, buffer)
      return git_changes_formatter(extensions.git_changes(window, buffer))
    end)
    local function lsp_srvname()
      local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return nil
      end
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          return client.name
        end
      end
      return nil
    end

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

    local diagnostic_display = diagnostic.make_buffer()

    require("el").setup({
      generator = function(window, buffer)
        local mode = extensions.gen_mode({ format_string = " %s " })
        local items = {
          { get_icon },
          { sections.maximum_width(builtin.file_relative, 0.60), required = true },
          { sections.collapse_builtin({ { " " }, { builtin.modified_flag } }) },
          { git_branch },
          { " " },
          { git_changes },
          { sections.split, required = true },
          { sections.split, required = true },
          { " " },
          {
            diagnostics({
              fmt = "[%s]",
              hl_err = "DiagnosticError",
              hl_warn = "DiagnosticWarn",
              hl_info = "DiagnosticInfo",
              hl_hint = "DiagnosticHint",
            }),
          },
          { "[" },
          { builtin.line_with_width(3) },
          { ":" },
          { builtin.column_with_width(2) },
          { "]" },
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
