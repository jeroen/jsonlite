library(RJSONIO)
con = textConnection("[1, 2, 3,\n4]"); fromJSON(con)

try({con = textConnection("[1, 2, 3,]"); fromJSON(con)})

