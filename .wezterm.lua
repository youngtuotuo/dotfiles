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
  -- {
  --   key = "W",
  --   mods = "CTRL|SHIFT|ALT",
  --   action = function()
  --     -- Set a workspace for coding on a current project
  --     -- Top pane is for the editor, bottom pane is for the build tool
  --     local project_dir = wezterm.home_dir .. "/wezterm"
  --     local tab, build_pane, window = wezterm.mux.spawn_window({
  --       workspace = "coding",
  --       cwd = project_dir,
  --     })
  --     local editor_pane = build_pane:split({
  --       direction = "Top",
  --       size = 0.6,
  --       cwd = project_dir,
  --     })
  --     -- may as well kick off a build in that pane
  --     build_pane:send_text("cargo build\n")
  --
  --     -- A workspace for interacting with a local machine that
  --     -- runs some docker containners for home automation
  --     local tab, pane, window = wezterm.mux.spawn_window({
  --       workspace = "automation",
  --       args = { "ssh", "vault" },
  --     })
  --
  --     -- We want to startup in the coding workspace
  --     wezterm.mux.set_active_workspace("coding")
  --   end,
  -- },
}
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.font_size = 10.0
  config.default_prog = { "pwsh.exe", "-NoLogo" }
end

-- and finally, return the configuration to wezterm
return config
