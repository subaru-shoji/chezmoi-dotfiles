function cv --wraps='chezmoi edit --apply /home/simple-web-system/.config/nvim/init.lua' 
  cd ~/.config/nvim
  nvim +PackerInstall
  chezmoi add -r .
  cd -
end
