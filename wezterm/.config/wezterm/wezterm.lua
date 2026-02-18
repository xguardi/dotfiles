local wezterm = require("wezterm")
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

-- config_builder creates a config table with validation and helpful errors
local config = wezterm.config_builder()

config = {

	-- Reloads config upon save
	automatically_reload_config = true,

	-- Leader key Ctrl-A like in tmux
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 },

	keys = {
		-- Split panes horizontally and vertically
		{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "|", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		-- Toggle zoom the pane to take up the full window.
		{ key = "m", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
		-- Create new Tab
		{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
		-- Prev Tab
		{ key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
		-- Next Tab
		{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
		-- Rename current Pane
		{
			key = ",",
			mods = "LEADER",
			action = wezterm.action.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		-- Move around panes vim-like
		{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
		-- resurrect
		{ key = "w", mods = "LEADER", action = resurrect.window_state.save_window_action() },
		{
			key = "l",
			mods = "LEADER",
			action = wezterm.action_callback(function(win, pane)
				resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
					local type = string.match(id, "^([^/]+)") -- match before '/'
					id = string.match(id, "([^/]+)$") -- match after '/'
					id = string.match(id, "(.+)%..+$") -- remove file extention
					local opts = {
						relative = true,
						restore_text = true,
						on_pane_restore = resurrect.tab_state.default_on_pane_restore,
					}
					if type == "workspace" then
						local state = resurrect.state_manager.load_state(id, "workspace")
						resurrect.workspace_state.restore_workspace(state, opts)
					elseif type == "window" then
						local state = resurrect.state_manager.load_state(id, "window")
						resurrect.window_state.restore_window(pane:window(), state, opts)
					elseif type == "tab" then
						local state = resurrect.state_manager.load_state(id, "tab")
						resurrect.tab_state.restore_tab(pane:tab(), state, opts)
					end
				end)
			end),
		},
	},

	-- We want the tab bar
	enable_tab_bar = true,
	-- When set to false, the tab bar is rendered using a retro aesthetic using the main terminal font
	use_fancy_tab_bar = true,

	-- Style
	default_cursor_style = "BlinkingBar",
	color_scheme = "Nord (Gogh)",
	font = wezterm.font("JetBrains Mono"),
	font_size = 14.5,

	-- Set the window_decorations as "RESIZE" which disables the title bar but enable the resizable border
	window_decorations = "RESIZE",
	window_padding = {
		left = 0,
		right = 0,
		top = 3,
		bottom = 0,
	},
	window_close_confirmation = "NeverPrompt",

	send_composed_key_when_left_alt_is_pressed = true,

	audible_bell = "Disabled",
}

-- Automatically save window every 15m
resurrect.state_manager.periodic_save({ interval_seconds = 15 * 60, save_windows = true })

return config
