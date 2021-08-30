function gyazo-cli --wraps=curl --description 'alias gyazo-cli=curl'
  curl https://upload.gyazo.com/api/upload -F "access_token=$GYAZO_ACCESS_TOKEN" \
  -F "imagedata=@$argv" | jq -r ".url"; 
end
