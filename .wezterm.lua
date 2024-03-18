-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })
config.color_scheme = "Builtin Tango Dark"

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

config.window_frame = {
  border_left_width = "0.15cell",
  border_right_width = "0.15cell",
  border_top_height = "0.1cell",
  border_bottom_height = "0.1cell",
  border_left_color = "grey",
  border_right_color = "grey",
  border_top_color = "grey",
  border_bottom_color = "grey",
}

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

config.keys = {
  { key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
  { key = "{", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(-1) },
  { key = "}", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(1) },
}
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.font_size = 10.0
end

-- and finally, return the configuration to wezterm
return config
