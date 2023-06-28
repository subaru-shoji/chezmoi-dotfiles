# Defined in - @ line 1
function t --wraps=tig --description 'alias t=tig'
  env TERM=xterm-256color tig  $argv;
end
