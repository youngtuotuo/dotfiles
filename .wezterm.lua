-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Builtin Tango Dark"
config.font = wezterm.font("CaskaydiaCove Nerd Font")

config.adjust_window_size_when_changing_font_size = false
config.harfbuzz_features = { "calt=1", "clig=0", "liga=0" }
config.selection_word_boundary = " \t\n{}[]()\"'`@.,;:"
config.audible_bell = "Disabled"

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
    action = wezterm.action.AttachDomain("ubuntu"),
  },
  {
    key = "D",
    mods = "CTRL|SHIFT",
    action = wezterm.action.DetachDomain("CurrentPaneDomain"),
  },
  { key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
  { key = "{", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(-1) },
  { key = "}", mods = "SHIFT|ALT", action = wezterm.action.MoveTabRelative(1) },
}
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.font_size = 10.0
  config.default_prog = { "pwsh.exe", "-NoLogo" }
end

-- and finally, return the configuration to wezterm
return config
