setMethod("asJSON", "array", function(x, collapse = TRUE, na = NULL, oldna = NULL, ...) {
  
  # reset na arg when called from data frame
  if(identical(na, "NA")){
    na <- oldna;
  }
  
  # row based json
  # we do not pass on reverse value, so that the inner matrix is consistent with default encoding
  tmp <- apply(x, 1, asJSON, na = na, ...)
  
  # collapse it
  if (collapse) {
    collapse(tmp)
  } else {
    tmp
  }
}) 
