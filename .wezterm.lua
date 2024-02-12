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
config.mouse_bindings = {
  {
    event = { Down = { streak = 3, button = "Left" } },
    action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
    mods = "NONE",
  },
}
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

local act = wezterm.action
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
    mods = "SHIFT|ALT",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "_",
    mods = "SHIFT|ALT",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "LeftArrow",
    mods = "ALT",
    action = act.ActivatePaneDirection("Left"),
  },
  {
    key = "RightArrow",
    mods = "ALT",
    action = act.ActivatePaneDirection("Right"),
  },
  {
    key = "UpArrow",
    mods = "ALT",
    action = act.ActivatePaneDirection("Up"),
  },
  {
    key = "DownArrow",
    mods = "ALT",
    action = act.ActivatePaneDirection("Down"),
  },
  {
    key = "9",
    mods = "ALT",
    action = wezterm.action.ShowLauncher,
  },
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.font_size = 10.0
  config.default_prog = { "pwsh.exe", "-NoLogo" }
  config.launch_menu = {
    {
      label = "PowerShell",
      args = { "pwsh.exe", "-NoLogo" },
    },
    {
      label = "WSL",
      args = { "wsl.exe", "--cd", "~" },
    },
  }
end

-- and finally, return the configuration to wezterm
return config
