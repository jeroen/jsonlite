setMethod("asJSON", "Date", function(x, Date = c("ISO8601", "epoch"), ...) {

  # Validate argument
  Date <- match.arg(Date)

  # select a schema
  output <- switch(Date,
    ISO8601 = as.character(x),
    epoch = unclass(x),
    default = stop("Invalid argument for 'Date':", Date)
  )

  # Dispatch to character encoding
  asJSON(output, ...)
})
