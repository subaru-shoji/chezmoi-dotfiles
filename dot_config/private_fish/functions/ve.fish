function ve 
	set repo_root (git rev-parse --show-toplevel)
	gh pr diff --name-only | fzf -m --query "$argv" --preview "bat  --color=always --line-range :100 {}"| awk -v pfx="$repo_root/" '{print pfx $0}' | xargs $EDITOR
end
