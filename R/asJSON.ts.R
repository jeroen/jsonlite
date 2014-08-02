#this is a placeholder for something better, hopefully
#I have no idea what is appropriate for time series
setMethod("asJSON", "ts", function(x, ...) {
  asJSON(as.vector(x), ...)
})
