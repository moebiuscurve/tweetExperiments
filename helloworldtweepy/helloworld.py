import tweepy, time, sys

API_KEY='put your \'Consumer Key (API Key)\' here'
API_SECRET='put your \'Consumer Secret (API Secret)\' here'
ACCESS_KEY='put your \'Access Token\' here'
ACCESS_SECRET='put your \'Access Token Secret\'  here'


auth=tweepy.OAuthHandler(API_KEY,API_SECRET)
auth.set_access_token(ACCESS_KEY,ACCESS_SECRET)
api=tweepy.API(auth)

while(True):
	#print("tweet(max 140 characters):WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW")
	print("tweet(max 140 characters):                                                                                                                                            <--END HERE")
	inp=raw_input("tweet(max 140 characters):")
	inplen=len(inp)
	if(inplen>140):
		print "exceeded length:", inplen
		continue
	try:
		api.update_status(inp)
	except Exception:
		print("either your keys are incorrect or you exceeded the number of characters (140 limit), try again")
