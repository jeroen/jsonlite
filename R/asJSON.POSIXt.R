setMethod("asJSON", "POSIXt", function(x, POSIXt = c("string", "ISO8601", "epoch",
  "mongo"), UTC = FALSE, digits, ...) {
  # note: UTC argument doesn't seem to be working consistently maybe use ?format
  # instead of ?as.character

  # Validate
  POSIXt <- match.arg(POSIXt)

  # Encode based on a schema
  if (POSIXt == "mongo") {
    if (is(x, "POSIXlt")) {
      x <- as.POSIXct(x)
    }
    return(asJSON(data.frame("$date" = floor(unclass(x) * 1000), check.names = FALSE), digits = 0, ...))
  } else if (POSIXt == "ISO8601") {
    return(asJSON(as.iso(x, UTC = UTC), ...))
  } else if (POSIXt == "string") {
    return(asJSON(as.character(x), ...))
  } else if (POSIXt == "epoch") {
    return(asJSON(floor(unclass(as.POSIXct(x)) * 1000), digits = digits, ...))
  } else {
    stop("Invalid value for argument POSIXt:", POSIXt)
  }
})
