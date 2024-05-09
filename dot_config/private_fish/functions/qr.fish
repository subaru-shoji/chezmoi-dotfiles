function qr --wraps='qrencode -t ansi' --description 'alias qr=qrencode -t ansi'
  qrencode -t ansi $argv
        
end
