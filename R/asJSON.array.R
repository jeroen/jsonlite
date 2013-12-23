setMethod("asJSON", "array", function(x, collapse = TRUE, na = NULL, oldna = NULL, 
  matrix = c("rowmajor", "columnmajor"), ...) {
  
  #validate
  matrix <- match.arg(matrix);
  
  # reset na arg when called from data frame
  if(identical(na, "NA")){
    na <- oldna;
  }
  
  # row based json
  # if collapse == FALSE, then this matrix is nested inside a data frame, 
  # and therefore row major is required to match dimensions
  margin <- ifelse(identical(matrix, "columnmajor") && isTRUE(collapse), length(dim(x)), 1);
  tmp <- apply(x, margin, asJSON, matrix = matrix, na = na, ...)
  
  # collapse it
  if (collapse) {
    collapse(tmp)
  } else {
    tmp
  }
}) 
