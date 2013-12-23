setMethod("asJSON", "array", function(x, collapse = TRUE, na = NULL, oldna = NULL, reverse=FALSE, ...) {
  
  # reset na arg when called from data frame
  if(identical(na, "NA")){
    na <- oldna;
  }
  
  # row based json
  tmp <- apply(x, ifelse(isTRUE(reverse), 1, length(dim(x))), asJSON, na = na, reverse=reverse, ...)
  
  # collapse it
  if (collapse) {
    collapse(tmp)
  } else {
    tmp
  }
}) 
