setMethod("asJSON", "array", function(x, collapse = TRUE, na = NULL, oldna = NULL, ...) {
  
  # reset na arg when called from data frame
  if(identical(na, "NA")){
    na <- oldna;
  }
  
  # row based json
  tmp <- apply(x, 1, asJSON, na = na, ...)
  
  # collapse it
  if (collapse) {
    collapse(tmp)
  } else {
    tmp
  }
}) 
