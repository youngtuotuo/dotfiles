-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
act { SpawnCommandInNewTab = { cwd = wezterm.home_dir } }

-- This table will hold the configuration.
local config = {}

local function getOS()
  -- ask LuaJIT first
  if jit then
    return jit.os
  end

  -- Unix, Linux variants
  local fh, err = assert(io.popen("uname -o 2>/dev/null", "r"))
  if fh then
    osname = fh:read()
  end

  return osname or "Windows"
end

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

if getOS() == "Windows" then
  config.default_prog = { "pwsh.exe" }
  config.window_decorations = "NONE"
else
  config.window_decorations = "RESIZE | MACOS_FORCE_ENABLE_SHADOW"
end
-- This is where you actually apply your config choices
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 11
config.adjust_window_size_when_changing_font_size = false
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.hide_tab_bar_if_only_one_tab = true
config.selection_word_boundary = " \t\n{}[]()\"'`@.,;:"
config.mouse_bindings = {
  {
    event = { Down = { streak = 3, button = "Left" } },
    action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
    mods = "NONE",
  },
}
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10
}
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_rate = 800
config.color_scheme = "Catppuccin Mocha"

config.colors = {
  cursor_fg = "black",
  cursor_bg = "#bfc7d5",
  cursor_border = "#bfc7d5",
}

config.tab_bar_at_bottom = true

config.colors = { background = "black" }

-- and finally, return the configuration to wezterm
return config
