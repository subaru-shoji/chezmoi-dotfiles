function ge 
  filename=gh pr diff --name-only | fzf --query "$argv" --preview "bat  --color=always --line-range :100 {}"
	echo $filename
	echo $filename | pbcopy
end
