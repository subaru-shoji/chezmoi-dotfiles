function ge 
  set filename (gh pr diff --name-only | fzf -m --query "$argv" --preview "bat  --color=always --line-range :100 {}")
  echo $filename
  echo $filename | pbcopy
end
