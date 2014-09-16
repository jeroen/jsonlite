data1 <- fromJSON("https://api.github.com/users/hadley/repos")
m <- mongo.create();
jsonlite:::mongo_write(data1, m, "test.blahad2", pagesize=10, na="null")
data2 <- jsonlite:::mongo_read(m, "test.blahad2")

