#!/bin/bash
set -o errexit
screen_name=hackingapis
tweet_count=5 # the number of tweets you want to retrieve
consumer_key=zNHUyLyV9jWeZ3gaEPUryBuxg
consumer_secret=VA9LTDjAFDkEEYZ6E2UScNlQJeZiEz6uonu7xGIdNnJ7cshAzj
oauth_token=2852508895-0cE4251jy0ZKrs2lDR0LvCT8BSc2R9N6hSl6yIm
oauth_secret=oJRo4l7MrcYmByMfzTVJ7vBpDrUIfyMKnk0fxldzZvq5y
timestamp=`date +%s`
nonce=`date +%s%T | openssl base64 | sed -e s'/[+=/]//g'`
signature_base_string="GET&https%3A%2F%2Fapi.twitter.com%2F1.1%2Fstatuses%2Fuser_timeline.json&count%3D${tweet_count}%26oauth_consumer_key%3D${consumer_key}%26oauth_nonce%3D${nonce}%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D${timestamp}%26oauth_token%3D${oauth_token}%26oauth_version%3D1.0%26screen_name%3D${screen_name}"
signature_key="${consumer_secret}&${oauth_secret}"
oauth_signature=`echo -n ${signature_base_string} | openssl dgst -sha1 -hmac ${signature_key} -binary | openssl base64 | sed -e s'/+/%2B/' -e s'/\//%2F/' -e s'/=/%3D/'`
header="Authorization: OAuth oauth_consumer_key=\"${consumer_key}\", oauth_nonce=\"${nonce}\", oauth_signature=\"${oauth_signature}\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"${timestamp}\", oauth_token=\"${oauth_token}\", oauth_version=\"1.0\""

curl_string="curl --get 'https://api.twitter.com/1.1/statuses/user_timeline.json' --data \"count=${tweet_count}&screen_name=${screen_name}\" --header \"Content-Type: application/x-www-form-urlencoded\" --header \"${header}\""

result=`curl --get 'https://api.twitter.com/1.1/statuses/user_timeline.json' --data "count=${tweet_count}&screen_name=${screen_name}" --header "Content-Type: application/x-www-form-urlencoded" --header "${header}"`
#result=`curl --get 'https://api.twitter.com/1.1/statuses/user_timeline.json' --data "count=${tweet_count}&screen_name=${screen_name}" --header "${header}"`
echo "${result}"

#echo "\n"
#echo "curl_string = "$curl_string
