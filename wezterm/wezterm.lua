local wezterm = require('wezterm')

config = wezterm.config_builder()

config = {
  automatically_reload_config = true,
  enable_tab_bar = false,
  window_close_confirmation = 'NeverPrompt',
  window_decorations = 'RESIZE', -- disable the title bar but enable the resizable border
  default_cursor_style = 'BlinkingBar',
  color_scheme = 'Nord (Gogh)',
  font = wezterm.font('JetBrains Mono'),
  font_size = 14.5,
  window_padding = {
    left = 3,
    right = 3,
    top = 0,
    bottom = 0,
  },
  send_composed_key_when_left_alt_is_pressed = true,
  audible_bell = 'Disabled',
}

return config
