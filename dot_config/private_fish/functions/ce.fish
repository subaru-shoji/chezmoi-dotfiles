# Defined in - @ line 1
function ce --wraps='chezmoi managed -i f | fzf | xargs chezmoi edit --apply' --description 'alias ce=chezmoi managed -i f | fzf | xargs chezmoi edit --apply'
	set SEARCH_RESULT (chezmoi managed --include=files | fzf-tmux -p)
	if test $status -eq 0
		chezmoi edit --apply $HOME/$SEARCH_RESULT
	end
end

