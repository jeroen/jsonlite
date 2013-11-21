#KEYS. Create your own appication key (only need to do this once) at https://dev.twitter.com/apps
consumer_key = "1XxSHU2XTchttIJapwwCQ";
consumer_secret = "TWFqJK66La96OgF12aWJn3kxq2fE6iNDTKrdzVeukg";

#library(devtools)
#install_github("JSONlite", "jeroenooms")

#Packages
library(httr)
library(JSONlite)

#basic auth
secret <- RCurl::base64(paste(consumer_key, consumer_secret, sep=":"));
req <- POST("https://api.twitter.com/oauth2/token", 
  config(httpheader = c("Authorization" = paste("Basic", secret), "Content-Type" = "application/x-www-form-urlencoded;charset=UTF-8")),
  body = "grant_type=client_credentials",
  multipart = FALSE
);

res <- fromJSON(rawToChar(req$content))
token <- paste("Bearer", res$access_token);

#API calls
call1 <- GET("https://api.twitter.com/1.1/statuses/user_timeline.json?count=3&screen_name=opencpu", config(httpheader = c("Authorization" = token)))
obj1 <- fromJSON(rawToChar(call1$content))

call2 <- GET("https://api.twitter.com/1.1/statuses/user_timeline.json?count=100&screen_name=hadleywickham", config(httpheader = c("Authorization" = token)))
obj2 <- fromJSON(rawToChar(call2$content))
