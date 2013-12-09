# NOTE: opencpu.encode is never upposed to use this function, because it
# unclasses every object first.  it is included for completeness.

setMethod("asJSON", "matrix", function(x, collapse = TRUE, ...) {
  # row based json
  tmp <- apply(x, 1, asJSON, ...)
  
  # collapse it
  if (collapse) {
    collapse(tmp)
  } else {
    tmp
  }
}) 
