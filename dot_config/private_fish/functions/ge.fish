function ge --wraps='gh pr diff --name-only | fzf --preview "bat  --color=always --line-range :100 {}" | xargs $EDITOR' --description 'alias ge=gh pr diff --name-only | fzf --preview "bat  --color=always --line-range :100 {}" | xargs $EDITOR'
  gh pr diff --name-only | fzf --preview "bat  --color=always --line-range :100 {}" | xargs $EDITOR $argv
        
end
