local wezterm = require("wezterm")

local is_mac = wezterm.target_triple:find("apple") ~= nil
local jp_fallback = is_mac and "Hiragino Sans" or "Noto Sans CJK JP"

return {
	default_prog = { "zsh", "-lc", "tmux" },
	font = wezterm.font_with_fallback({
		"Hack Nerd Font Mono",
		jp_fallback,
	}),
	font_size = 13,
	color_scheme = "Tokyo Night Moon",
	use_ime = true,
	xim_im_name = "fcitx",
	ime_preedit_rendering = "System",
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
		{
			key = 'Enter',
			mods = 'SHIFT',
			action = wezterm.action.SendString('\n')
		},
	},
	warn_about_missing_glyphs = false,
}
