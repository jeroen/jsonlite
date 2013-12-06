setMethod("asJSON", "character", function(x, container = TRUE, na = c("default", "null", "string"), ...) {
  
  # 0 vector is not handled properly by paste()
  if (!length(x)) 
    return("[]")
  
  # vectorized escaping
  tmp <- deparse_vector(x)
  
  # validate NA
  na <- match.arg(na)
  if (na %in% c("default", "null")) {
    tmp[is.na(x)] <- "null"
  } else {
    tmp[is.na(x)] <- "\"NA\""
  }
  
  # collapse
  tmp <- paste(tmp, collapse = ", ")
  
  # this is almost always true, except for class 'scalar'
  if (container) {
    tmp <- paste("[", tmp, "]")
  }
  
  # return
  return(tmp)
}) 
