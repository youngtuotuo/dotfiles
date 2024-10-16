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

config.keys = {
  { key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
  {
    key = "t",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SpawnCommandInNewTab({
      cwd = wezterm.home_dir,
    }),
  },
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
}

config.font_size = 14.0
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "pwsh.exe", "-nologo" }
  config.font_size = 10.0
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

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.adjust_window_size_when_changing_font_size = false
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.selection_word_boundary = " \t\n{}[]()\"'`@.,;:"
config.audible_bell = "Disabled"

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_ease_in = "Constant"
config.hide_tab_bar_if_only_one_tab = true
config.cursor_blink_ease_out = "Constant"

-- and finally, return the configuration to wezterm
return config
