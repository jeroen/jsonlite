library(RJSONIO)
if(!is.null(getOption('NYTimesAPI'))) {
 news = getForm('http://api.nytimes.com/svc/search/v1/article',  'api-key' = getOption('NYTimesAPI')["Article Search"], query = "climate change")
} else
 load("newsUTF8.rda")

fromJSON(news)
