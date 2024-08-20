if test (uname) = "Darwin"
	source ~/.config/fish/os/mac_config.fish
end

fish_add_path ~/bin
fish_add_path $YARN_PATH
fish_add_path ~/.dotnet/tools
fish_add_path ~/Applications
fish_add_path $HOME/.local/bin/
fish_add_path $HOME/.cargo/bin/
fish_add_path /usr/share/applications/

set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path $PNPM_HOME

source ~/.asdf/asdf.fish

if test "$TERM" = "tmux-256color"; or test -n "$ZELLIJ"
	source ~/.asdf/completions/asdf.fish

	zoxide init fish | source
	direnv hook fish | source
	starship init fish | source
end
  
