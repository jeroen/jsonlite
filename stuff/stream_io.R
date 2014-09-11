library(jsonlite)
library(dplyr)
con_in <- url("http://jeroenooms.github.io/data/diamonds.mjson")
con_out <- file(tmp <- tempfile(), open = "w")
stream_in(con_in, handler = function(df){
  df <- dplyr::filter(df, carat > 1)
  stream_out(df, con_out)
}, pagesize = 500)
close(con_out)
