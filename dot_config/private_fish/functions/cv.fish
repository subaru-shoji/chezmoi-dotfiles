function cv --wraps='chezmoi edit --apply /home/simple-web-system/.config/nvim/init.lua' 
  cd ~/.config/nvim
  if test $EDITOR = nvim
    $EDITOR
  else
    $EDITOR .
  end
  chezmoi add -r .
  cd -
end
