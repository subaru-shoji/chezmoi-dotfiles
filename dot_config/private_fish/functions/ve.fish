function ve 
  set filepath (gh pr diff --name-only | fzf --query "$argv" --preview "bat  --color=always --line-range :100 {}")
	set repo_root (git rev-parse --show-toplevel)
	set abs_filepath "$repo_root/$filepath"
  $EDITOR $abs_filepath
end
