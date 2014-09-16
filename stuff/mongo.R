library(rmongodb)
library(jsonlite)

x1 <- fromJSON("https://api.github.com/users/hadley/repos")
m <- mongo.create();
table <- "test.mydata"
mongo.remove(m, table)
jsonlite:::mongo_write(x1, m, table, pagesize = 10, na="null")
x2 <- jsonlite:::mongo_read(m, table, pagesize = 5)
identical(x1, x2)
