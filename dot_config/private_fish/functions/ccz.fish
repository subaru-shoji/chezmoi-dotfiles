function ccz --description 'cd to chezmoi source directory'
  if test (count $argv) -eq 0
    cd (chezmoi source-path)
  else
    cd (chezmoi source-path $argv)
  end
end
