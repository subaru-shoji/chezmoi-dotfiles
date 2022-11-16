function ff --wraps='git diff develop...HEAD --name-only --diff-filter=d | fzf --preview "bat  --color=always --style=header,grid --line-range :100 {}" | xargs --no-run-if-empty code' --description 'alias ff=git diff develop...HEAD --name-only --diff-filter=d | fzf --preview "bat  --color=always --style=header,grid --line-range :100 {}" | xargs --no-run-if-empty code'
  git diff develop...HEAD --name-only --diff-filter=d | fzf --preview "bat  --color=always --style=header,grid --line-range :100 {}" | xargs --no-run-if-empty code $argv; 
end
