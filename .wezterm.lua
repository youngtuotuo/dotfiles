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
  }
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.font = wezterm.font("Cascadia Mono", { weight = "Regular" })
  config.default_prog = { "pwsh.exe", "-nologo" }
elseif wezterm.target_triple == "aarch64-apple-darwin" then
  config.font = wezterm.font("SF Mono", { weight = "Regular" })
  table.insert(
    config.keys,
    { key = "t", mods = "CMD", action = wezterm.action.SpawnCommandInNewTab({
      cwd = wezterm.home_dir,
    }) }
  )
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
  config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
end
config.font_size = 14.0

config.adjust_window_size_when_changing_font_size = false
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.selection_word_boundary = " \t\n{}[]()\"'`@.,;:"
config.audible_bell = "Disabled"

config.ssh_domains = {
  {
    name = "ubuntu",
    remote_address = "192.168.0.123",
    username = "support",
  },
}

config.hide_tab_bar_if_only_one_tab = true
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
}

-- and finally, return the configuration to wezterm
return config
