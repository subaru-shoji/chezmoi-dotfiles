function cv --wraps='chezmoi edit --apply /home/simple-web-system/.config/nvim/init.lua' --description 'alias cv=chezmoi edit --apply /home/simple-web-system/.config/nvim/init.lua'
  chezmoi edit --apply /home/simple-web-system/.config/nvim/init.lua $argv; 
end
