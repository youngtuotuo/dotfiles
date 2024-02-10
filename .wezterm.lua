-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

local fg = wezterm.color.parse("#cacaca")
local bg = wezterm.color.parse("#000000")
local active_bg = wezterm.color.parse("#333233")

wezterm.on("update-right-status", function(window)
  local time = wezterm.strftime("%H:%M")

  window:set_right_status(wezterm.format({
    { Foreground = { Color = fg } },
    { Background = { Color = bg } },
    { Text = time .. " " },
  }))
end)

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.status_update_interval = 50

local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, _, _, _, _, _)
  local foreground = fg
  if tab.is_active then
    foreground = fg:lighten(0.7)
  else
    foreground = fg:darken(0.6)
  end

  local title = tab_title(tab)

  return {
    { Background = { Color = bg } },
    { Text = " " },
    { Background = { Color = bg } },
    { Foreground = { Color = foreground } },
    { Text = (tab.tab_index + 1) .. ": " .. title },
    { Background = { Color = bg } },
    { Text = " " },
  }
end)

config.colors = {
  cursor_fg = bg,
  cursor_bg = fg,
  tab_bar = {
    inactive_tab_edge = bg,
  },
}

config.color_scheme = "Builtin Tango Dark"
config.font = wezterm.font("FiraCode Nerd Font Mono")

config.adjust_window_size_when_changing_font_size = false
config.harfbuzz_features = { "calt=1", "clig=0", "liga=0" }
config.selection_word_boundary = " \t\n{}[]()\"'`@.,;:"
config.mouse_bindings = {
  {
    event = { Down = { streak = 3, button = "Left" } },
    action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
    mods = "NONE",
  },
}
config.audible_bell = "Disabled"

config.window_decorations = "RESIZE"

config.window_frame = {
  border_top_height = "0.1cell",
  border_left_width = "0.2cell",
  border_right_width = "0.2cell",
  border_bottom_height = "0.1cell",
  border_top_color = active_bg,
  border_left_color = active_bg,
  border_right_color = active_bg,
  border_bottom_color = active_bg,
  active_titlebar_bg = bg,
  inactive_titlebar_bg = bg,
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- config.hide_tab_bar_if_only_one_tab = true

config.ssh_domains = {
  {
    -- This name identifies the domainV
    name = "ubuntu",
    -- The hostname or address to connect to. Will be used to match settings
    -- from your ssh config file
    remote_address = "192.168.0.123",
    -- The username to use on the remote host
    username = "support",
  },
}

config.keys = {
  {
    key = "U",
    mods = "CTRL|SHIFT",
    action = act.AttachDomain("ubuntu"),
  },
  {
    key = "D",
    mods = "CTRL|SHIFT",
    action = act.DetachDomain("CurrentPaneDomain"),
  },
  { key = "{", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
  { key = "}", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
  {
    key = "E",
    mods = "CTRL|SHIFT",
    action = act.PromptInputLine({
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
  {
    key = "|",
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "_",
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "9",
    mods = "CTRL",
    action = act.PaneSelect({
      alphabet = "1234567890",
    }),
  },
  {
    key = "0",
    mods = "CTRL",
    action = act.PaneSelect({
      mode = "SwapWithActive",
      alphabet = "1234567890",
    }),
  },
  {
    key = "9",
    mods = "ALT",
    action = wezterm.action.ShowLauncherArgs { flags = 'LAUNCH_MENU_ITEMS' },
  },
}

local launch_menu = {}
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "pwsh.exe" }
  local msys2 = {
    "C:/msys64/usr/bin/env.exe",
    "MSYS=enable_pcon", -- Enable pseudo console API for msys (maybe not needed under wezterm?) Actually, needed - without it, Ctrl-D does not close the terminal!
    "MSYSTEM=UCRT64",
    "/bin/bash",
    "--login",
  }
  table.insert(launch_menu, {
    label = "msys2 bash",
    args = msys2,
  })
  table.insert(launch_menu, {
    label = "Powershell",
    args = { "pwsh.exe" },
  })
end
config.launch_menu = launch_menu

-- and finally, return the configuration to wezterm
return config
