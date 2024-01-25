-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

if package.config:sub(1, 1) == "\\" then
  config.default_prog = { "pwsh.exe" }
end
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
config.colors = {
  cursor_fg = "black",
  cursor_bg = "grey",
}

config.window_frame = {
  border_left_width = "0.2cell",
  border_right_width = "0.2cell",
  border_bottom_height = "0.1cell",
  border_left_color = "#333233",
  border_right_color = "#333233",
  border_bottom_color = "#333233",
}
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

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

local function isVim(pane)
  local tty = pane:get_tty_name()
  if tty == nil then
    return false
  end

  local success, _, _ = wezterm.run_child_process({
    "sh",
    "-c",
    "ps -o state= -o comm= -t" .. wezterm.shell_quote_arg(tty) .. " | " .. "grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'",
  })

  return success
end

local function activatePane(window, pane, direction, vim_key)
  if isVim(pane) then
    window:perform_action(
      act.Multiple({
        act.SendKey({ key = "w", mods = "CTRL" }),
        act.SendKey({ key = vim_key }),
      }),
      pane
    )
  else
    window:perform_action(act.ActivatePaneDirection(direction), pane)
  end
end

wezterm.on("ActivatePaneRight", function(window, pane)
  activatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneLeft", function(window, pane)
  activatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneUp", function(window, pane)
  activatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDown", function(window, pane)
  activatePane(window, pane, "Down", "j")
end)

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
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "_",
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "9",
    mods = "CTRL",
    action = act.PaneSelect({
      alphabet = "1234567890",
    }),
  },
  {
    key = "0",
    mods = "CTRL",
    action = act.PaneSelect({
      mode = "SwapWithActive",
      alphabet = "1234567890",
    }),
  },
  { key = "h", mods = "CTRL|SHIFT", action = act.EmitEvent("ActivatePaneLeft") },
  { key = "j", mods = "CTRL|SHIFT", action = act.EmitEvent("ActivatePaneDown") },
  { key = "k", mods = "CTRL|SHIFT", action = act.EmitEvent("ActivatePaneUp") },
  { key = "l", mods = "CTRL|SHIFT", action = act.EmitEvent("ActivatePaneRight") },
}

-- and finally, return the configuration to wezterm
return config
