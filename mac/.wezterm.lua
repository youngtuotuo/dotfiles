-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end
local act = wezterm.action

config.font_size = 14.0
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_ease_in = "Constant"
config.hide_tab_bar_if_only_one_tab = true
config.cursor_blink_ease_out = "Constant"

-- and finally, return the configuration to wezterm
return config
