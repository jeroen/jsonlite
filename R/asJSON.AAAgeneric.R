setGeneric("asJSON", function(x, pretty = FALSE, ...) {
  ans <- standardGeneric("asJSON")
  if (isTRUE(pretty)) {
    ans <- prettify(ans)
  }
  return(ans)
}) 
