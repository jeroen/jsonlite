library(RJSONIO)
ans = fromJSON("[3.14e4, 3.14E4]")
stopifnot(ans[[1]] == ans[[2]])
