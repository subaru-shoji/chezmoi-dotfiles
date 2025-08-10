if test (uname) = "Darwin"
	source ~/.config/fish/os/mac_config.fish
end

fish_add_path ~/bin
fish_add_path $YARN_PATH
fish_add_path $HOME/.npm-global/bin
fish_add_path ~/.dotnet/tools
fish_add_path ~/Applications
fish_add_path $HOME/.local/bin/
fish_add_path $HOME/.cargo/bin/
fish_add_path /usr/share/applications/

set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path $PNPM_HOME

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

if test "$TERM" = "tmux-256color"; or test -n "$ZELLIJ"
	zoxide init fish | source
	direnv hook fish | source
	starship init fish | source
end
  
