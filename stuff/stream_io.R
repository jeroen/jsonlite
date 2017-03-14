library(jsonlite)

# Full JSON stream IO: stream from URL to file.
# Calculate delays for flights over 1000 miles in batches of 5k
library(dplyr)
con_in <- gzcon(url("http://jeroen.github.io/data/nycflights13.mjson.gz"))
con_out <- file(tmp <- tempfile(), open = "w")
stream_in(con_in, handler = function(df){
  df <- dplyr::filter(df, distance > 1000)
  df <- dplyr::mutate(df, delta = dep_delay - arr_delay)
  stream_out(df, con_out, pagesize = 1000)
}, pagesize = 5000)
close(con_out)

# stream it back in
mydata <- stream_in(file(tmp))
nrow(mydata)
unlink(tmp)
