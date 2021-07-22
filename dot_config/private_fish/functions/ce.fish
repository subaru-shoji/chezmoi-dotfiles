# Defined in - @ line 1
function ce --wraps='chezmoi managed -i f | fzf | xargs chezmoi edit --apply' --description 'alias ce=chezmoi managed -i f | fzf | xargs chezmoi edit --apply'
  chezmoi edit --apply (chezmoi managed | fzf)
end
