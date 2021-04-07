# Defined in - @ line 1
function pbcopy --wraps='xclip -selection clipboard' --description 'alias pbcopy=xclip -selection clipboard'
  switch (uname)
  case Darwin
      /usr/bin/pbcopy
  case '*'
      xclip -selection clipboard $argv;
  end
end
