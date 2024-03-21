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
config.color_scheme = "Apple System Colors"

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
  border_bottom_height = "0.1cell",
  border_left_color = "rgb(100, 100, 100)",
  border_right_color = "rgb(100, 100, 100)",
  border_bottom_color = "rgb(100, 100, 100)",
}

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.keys = {
  { key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
}

-- and finally, return the configuration to wezterm
return config
