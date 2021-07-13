# Defined via `source`
function gps --wraps='git push origin HEAD' --description 'alias gps=git push origin HEAD'
  git push origin HEAD $argv; 
end
