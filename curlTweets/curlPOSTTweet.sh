#!/bin/bash
set -o errexit
consumer_key=zNHUyLyV9jWeZ3gaEPUryBuxg
consumer_secret=VA9LTDjAFDkEEYZ6E2UScNlQJeZiEz6uonu7xGIdNnJ7cshAzj
oauth_token=2852508895-0cE4251jy0ZKrs2lDR0LvCT8BSc2R9N6hSl6yIm
oauth_secret=oJRo4l7MrcYmByMfzTVJ7vBpDrUIfyMKnk0fxldzZvq5y
message="curl is cool"
message_string=`echo -n ${message}|sed -e s'/ /%2520/g'`
message_curl=`echo -n ${message}|sed -e s'/ /+/g'`
timestamp=`date +%s`
nonce=`date +%s%T | openssl base64 | sed -e s'/[+=/]//g'`
api_version=1.1
signature_base_string="POST&https%3A%2F%2Fapi.twitter.com%2F${api_version}%2Fstatuses%2Fupdate.json&oauth_consumer_key%3D${consumer_key}%26oauth_nonce%3D${nonce}%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D${timestamp}%26oauth_token%3D${oauth_token}%26oauth_version%3D1.0%26status%3D${message_string}"
signature_key="${consumer_secret}&${oauth_secret}"
oauth_signature=`echo -n ${signature_base_string} | openssl dgst -sha1 -hmac ${signature_key} -binary | openssl base64 | sed -e s'/+/%2B/g' -e s'/\//%2F/g' -e s'/=/%3D/g'`

header="Authorization: OAuth oauth_consumer_key=\"${consumer_key}\", oauth_nonce=\"${nonce}\", oauth_signature=\"${oauth_signature}\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"${timestamp}\", oauth_token=\"${oauth_token}\", oauth_version=\"1.0\""



result=`curl -X POST "https://api.twitter.com/${api_version}/statuses/update.json" --data "status=${message_curl}" --header "Content-Type: application/x-www-form-urlencoded" --header "${header}" --verbose`

echo "${result}"

curl_string="curl -X 'POST' \"https://api.twitter.com/${api_version}/statuses/update.json\" --data \"status=${message_curl}\" --header \"Content-Type: application/x-www-form-urlencoded\" --header \"${header}\" --verbose"

#echo "\n"
#echo "message_string = "$message_string
#echo "\n"
#echo "message_curl = "$message_curl
#echo "\n"
#echo "timestamp = "$timestamp
#echo "\n"
#echo "noonce = "$nonce
#echo "\n"
#echo "signature_base_string = "$signature_base_string
#echo "\n"
#echo "signature_key = "$signature_key
#echo "\n"
#echo "oauth_signature = "$oauth_signature
#echo "\n"
#echo "header = "$header
#echo "\n"
#echo "curl_string = "$curl_string
#result=`curl -X POST 'https://api.twitter.com/1.1/statuses/update.json' --data "status=${message_string}&screen_name=${screen_name}" --header "Content-Type: application/x-www-form-urlencoded" --header "${header}"`
