source ~/.asdf/asdf.fish
source ~/.asdf/completions/asdf.fish

if test (uname) = "Darwin"
	source ~/.config/fish/os/mac_config.fish
end

starship init fish | source
zoxide init fish | source
direnv hook fish | source
  
