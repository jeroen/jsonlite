library(RJSONIO)

x = paste(readLines("utf/news.txt"), collapse = "\n")
r = charToRaw(x)
.Call("R_readFromJSON", r, 20L, TRUE, function(x, ...){}, NULL, c(0L, 5619L))

a  = readBin("utf/news.txt", "raw", file.info("utf/news.txt")[1, "size"])
.Call("R_readFromJSON", a, 20L, TRUE, function(x, ...){}, NULL, c(0L, 5619L))

i = as.integer(charToRaw(x))
.Call("R_readFromJSON", i, 20L, TRUE, function(x, ...){}, NULL, c(0L, 5619L))
