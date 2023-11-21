local wezterm = require("wezterm")

local use_ime = false
if wezterm.target_triple == "aarch64-apple-darwin" then
	use_ime = true
end

return {
	default_prog = { "zsh", "-lc", "tmux" },
	-- font = wezterm.font("FiraCode Nerd Font Mono"),
	font = wezterm.font("Hack Nerd Font Mono"),
	font_size = 13,
	use_ime = use_ime,
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
}
