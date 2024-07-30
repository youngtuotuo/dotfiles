-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.keys = {
  { key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
  {
    key = "t",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SpawnCommandInNewTab({
      cwd = wezterm.home_dir,
    }),
  },
}

config.font_size = 16.0
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "pwsh.exe", "-nologo" }
  config.font_size = 14.0
  config.launch_menu = {
    {
      label = "PowerShell",
      args = { "pwsh.exe", "-nologo" },
    },
    {
      label = "WSL",
      args = { "wsl.exe", "~" },
    },
    {
      label = "CMD",
      args = { "cmd.exe" },
    },
    {
      label = "NuShell",
      args = { "nu.exe" },
    },
  }
elseif wezterm.target_triple == "aarch64-apple-darwin" then
  table.insert(
    config.keys,
    { key = "t", mods = "CMD", action = wezterm.action.SpawnCommandInNewTab({
      cwd = wezterm.home_dir,
    }) }
  )
end

config.initial_cols = 96
config.initial_rows = 24
config.window_background_opacity = 1
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = { left = 0, right = 15, top = 0, bottom = 0 }
config.enable_scroll_bar = true

config.adjust_window_size_when_changing_font_size = false
-- config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.selection_word_boundary = " \t\n{}[]()\"'`@.,;:"
config.audible_bell = "Disabled"

-- config.hide_tab_bar_if_only_one_tab = true
local scheme_def = wezterm.color.get_builtin_schemes()["Wez"]
config.colors = {
  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = "rgb(198,198,207)",
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = "black",
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = "rgb(198,198,207)",
  tab_bar = {
    active_tab = {
      bg_color = scheme_def.background,
      fg_color = scheme_def.foreground,
    },
  },
}

-- and finally, return the configuration to wezterm
return config
