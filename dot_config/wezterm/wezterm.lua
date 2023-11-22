local wezterm = require("wezterm")

return {
	default_prog = { "zsh", "-lc", "tmux" },
	-- font = wezterm.font("FiraCode Nerd Font Mono"),
	font = wezterm.font("Hack Nerd Font Mono"),
	font_size = 13,
	color_scheme = "Tokyo Night Moon",
	use_ime = true,
	window_background_opacity = 0.87,
	hide_tab_bar_if_only_one_tab = true,
	keys = {
		-- Turn off the default CMD-m Hide action, allowing CMD-m to
		-- be potentially recognized and handled by the tab
		{
			key = "Enter",
			mods = "ALT",
			action = wezterm.action.DisableDefaultAssignment,
		},
	},
	warn_about_missing_glyphs = false,
}
