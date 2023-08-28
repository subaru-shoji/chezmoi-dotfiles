function keyboard_disable --wraps=xinput\ --list\ \|\ grep\ \"AT\ Translated\ Set\"\ \|\ grep\ -oP\ \"\(\?\<=id\\=\)\\d\*\"\ \|\ xargs\ xinput\ --disable --description alias\ keyboard_disable=xinput\ --list\ \|\ grep\ \"AT\ Translated\ Set\"\ \|\ grep\ -oP\ \"\(\?\<=id\\=\)\\d\*\"\ \|\ xargs\ xinput\ --disable
  xinput --list | grep "AT Translated Set" | grep -oP "(?<=id\=)\d*" | xargs xinput --disable $argv; 
end
