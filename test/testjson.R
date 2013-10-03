library(encode)
file.exists("test.json");
isValidJSON("test.json");
obj <- fromJSON(readLines("test.json"));

