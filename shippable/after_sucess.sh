#!/usr/bin/env bash
###### Upload to DropBox using v2 api
curl -X POST https://api.dropboxapi.com/2/files/create_folder_v2
    --header "Authorization: Bearer $AUTH_TOKEN"
    --header "Content-Type: application/json"
    --data "{\"path\": \"/JniFiles/FreeRDP\",\"autorename\": false}"

cd "client/Android/Studio/freeRDPCore/src/main"
newDate = date "+%d-%m-%y"
zip -r $newDate.zip jniLibs
APK_FILENAME=$(find . -type f -name "*.zip")
echo $APK_FILENAME
for item in $APK_FILENAME
do
  echo $item
  #filename=$(basename $item)
curl -X POST https://content.dropboxapi.com/2/files/upload \
  --header "Authorization: Bearer $AUTH_TOKEN" \
    --header "Dropbox-API-Arg: {\"path\": \"/JniFiles/FreeRDP/$APK_FILENAME\",\"mode\": \"add\",\"autorename\": true,\"mute\": false,\"strict_conflict\": false}" \
    --header "Content-Type: application/octet-stream" \
    --data-binary @$item

  #curl -X POST --user "$AUTH_TOKEN" "https://api.bitbucket.org/2.0/repositories/affordableapps/trudesktop/downloads" --form files=@$item
done