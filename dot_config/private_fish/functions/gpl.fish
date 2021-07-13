# Defined via `source`
function gpl --wraps='git pull origin HEAD' --description 'alias gpl=git pull origin HEAD'
  git pull origin HEAD $argv; 
end
