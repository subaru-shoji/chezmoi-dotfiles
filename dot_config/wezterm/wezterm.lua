local wezterm = require("wezterm")

local use_ime = false
if wezterm.target_triple == "aarch64-apple-darwin" then
	use_ime = true
end

return {
	default_prog = { "zsh", "-lc", "tmux" },
	font = wezterm.font("FiraCode Nerd Font Mono"),
	use_ime = use_ime,
}
