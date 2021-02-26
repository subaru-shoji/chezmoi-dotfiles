# Defined in - @ line 1
function cc --wraps='chezmoi cd' --description 'alias cc=chezmoi cd'
  chezmoi cd $argv;
end
