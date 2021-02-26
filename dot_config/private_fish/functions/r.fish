# Defined in - @ line 1
function r --wraps=ranger --wraps=ranger-cd --description 'alias r=ranger-cd'
  ranger-cd  $argv;
end
