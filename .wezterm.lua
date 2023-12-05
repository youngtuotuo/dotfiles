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

local dimmer = { brightness = 0.05 }
local bg = "/github/dotfiles/pictures/future-buildings-minimal-ve.jpg"
local file = ""
if os.getenv("HOME") then
  file = os.getenv("HOME") .. bg
end

if getOS() == "Windows" then
  file = "C:/Users/User" .. bg
  config.default_prog = { "pwsh.exe" }
  -- config.window_decorations = "NONE"
else
  config.window_decorations = "TITLE | RESIZE | MACOS_FORCE_ENABLE_SHADOW"
end
-- This is where you actually apply your config choices
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14
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
  left = "2cell",
  right = "2cell",
  top = "0.5cell",
  bottom = "0.5cell"
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
config.window_frame = {
  border_left_width = '0.2cell',
  border_right_width = '0.2cell',
  border_bottom_height = '0.1cell',
  border_left_color = '#333233',
  border_right_color = '#333233',
  border_bottom_color = '#333233',
}

config.background = {
  {
    source = {
      File = file,
    },
    hsb = dimmer,
  },
}
config.tab_bar_at_bottom = true
config.ssh_domains = {
  {
    name = 'ubuntu',
    remote_address = '192.168.0.123',
    username = 'support',
  },
}


-- and finally, return the configuration to wezterm
return config
