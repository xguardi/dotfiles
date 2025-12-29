local wezterm = require('wezterm')

-- config_builder creates a config table with validation and helpful errors
config = wezterm.config_builder()

config = {
  
  -- Reloads config upon save
  automatically_reload_config = true,

  -- Leader key Ctrl-A like in tmux
  leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000, },

  keys = {
    
    -- Split panes horizontally and vertically
    { key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }), },
    { key = "|", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }), },

    -- Toggle zoom the pane to take up the full window. 
    { key = "m", mods = "LEADER", action = wezterm.action.TogglePaneZoomState, },

    -- Create new Tab
    { key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain"), },
    -- Prev Tab
    { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1), },
    -- Next Tab
    { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1), },

    -- Rename current Pane
    {
        key = ',',
        mods = 'LEADER',
        action = wezterm.action.PromptInputLine {
          description = 'Enter new name for tab',
          action = wezterm.action_callback(
            function(window, pane, line)
              if line then
                window:active_tab():set_title(line)
              end
            end
            ),
    },
  },
},

  -- We want the tab bar
  enable_tab_bar = true,
  -- When set to false, the tab bar is rendered using a retro aesthetic using the main terminal font
  use_fancy_tab_bar = true,

  -- Style
  default_cursor_style = 'BlinkingBar',
  color_scheme = 'Nord (Gogh)',
  font = wezterm.font('JetBrains Mono'),
  font_size = 14.5,

  -- Set the window_decorations as "RESIZE" which disables the title bar but enable the resizable border
  window_decorations = "RESIZE",
  window_padding = {
    left = 0,
    right = 0,
    top = 3,
    bottom = 0,
  },
  window_close_confirmation = 'NeverPrompt',

  send_composed_key_when_left_alt_is_pressed = true,

  audible_bell = 'Disabled',
}

return config
