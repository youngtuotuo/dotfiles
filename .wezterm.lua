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
end
config.window_decorations = "TITLE | RESIZE | MACOS_FORCE_ENABLE_SHADOW"
-- This is where you actually apply your config choices
config.font = wezterm.font("JetBrainsMono Nerd Font")
-- config.font_size = 14
config.adjust_window_size_when_changing_font_size = false
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
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

config.colors = {
  tab_bar = {
    background = 'rgba(0,0,0,0)',
  }
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
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.ssh_domains = {
  {
    -- This name identifies the domainV
    name = 'ubuntu',
    -- The hostname or address to connect to. Will be used to match settings
    -- from your ssh config file
    remote_address = '192.168.0.123',
    -- The username to use on the remote host
    username = 'support',
  },
}
config.keys = {
  { key = 'U', mods = 'CTRL|SHIFT', action = act.AttachDomain 'ubuntu' },
  {
    key = 'D',
    mods = 'CTRL|SHIFT',
    action = act.DetachDomain 'CurrentPaneDomain',
  },
  { key = '{', mods = 'SHIFT|ALT', action = act.MoveTabRelative(-1) },
  { key = '}', mods = 'SHIFT|ALT', action = act.MoveTabRelative(1) },
  {
    key = 'E',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}

-- and finally, return the configuration to wezterm
return config
