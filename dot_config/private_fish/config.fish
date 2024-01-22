source ~/.asdf/asdf.fish
source ~/.asdf/completions/asdf.fish

if test (uname) = "Darwin"
	source ~/.config/fish/os/mac_config.fish
end

starship init fish | source
zoxide init fish | source
direnv hook fish | source
  
fish_add_path ~/bin
fish_add_path (yarn global bin)
fish_add_path ~/.dotnet/tools
