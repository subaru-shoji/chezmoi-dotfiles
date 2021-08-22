function cd-gitroot --wraps='cd (git rev-parse --show-toplevel)' --description 'alias cd-gitroot=cd (git rev-parse --show-toplevel)'
  cd (git rev-parse --show-toplevel) $argv; 
end
