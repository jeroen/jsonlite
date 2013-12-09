setMethod("asJSON", "factor", function(x, factor = c("string", "integer"), ...) {
  # validate
  factor <- match.arg(factor)
  
  # dispatch
  if (factor == "integer") {
    # encode factor as enum
    asJSON(unclass(x), ...)
  } else {
    # encode as strings
    asJSON(as.character(x), ...)
  }
})
