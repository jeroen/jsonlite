setMethod("asJSON", "Date", function(x, Date = c("ISO8601", "epoch"), ...) {
  
  # Validate argument
  Date <- match.arg(Date)
  
  # select a schema
  output <- switch(Date, ISO8601 = as.iso(x), epoch = unclass(x), default = stop("Invalid argument for 'Date':", Date))
  return(asJSON(output, ...))
}) 
