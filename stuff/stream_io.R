library(jsonlite)
library(dplyr)
con_in <- gzcon(url("http://jeroenooms.github.io/data/hflights.mjson.gz"))
con_out <- file(tmp <- tempfile(), open = "w")
stream_in(con_in, handler = function(df){
  df <- dplyr::filter(df, Distance > 1000)
  stream_out(df, con_out, 1000)
}, pagesize = 5000)
close(con_out)

