setMethod("asJSON", "character", function(x, collapse = TRUE, na = c("default", 
  "null", "string", "NA"), ...) {
  # 0 vector is not handled properly by paste()
  if (!length(x)) {
    return("[]")
  }
  
  # vectorized escaping
  tmp <- deparse_vector(x)
  
  # validate NA
  na <- match.arg(na)
  if (na %in% c("default", "null")) {
    tmp[is.na(x)] <- "null"
  } else if(na %in% "string") {
    tmp[is.na(x)] <- "\"NA\""
  }
  
  # this is almost always true, except for class 'scalar'
  if (isTRUE(collapse)) {
    collapse(tmp)
  } else {
    tmp
  }
}) 
