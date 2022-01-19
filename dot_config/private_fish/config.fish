source ~/.asdf/asdf.fish

starship init fish | source
zoxide init fish | source
direnv hook fish | source

type -q k3d; k3d completion fish | source
