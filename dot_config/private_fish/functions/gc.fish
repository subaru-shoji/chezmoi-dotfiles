# Defined via `source`
function gc --wraps='git branch | fzf | xargs git switch' --description 'alias gc=git branch | fzf | xargs git switch'
  git branch | fzf | xargs git switch $argv; 
end
