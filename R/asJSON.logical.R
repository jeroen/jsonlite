setMethod("asJSON", "logical", function(x, container = TRUE, na = "null", ...) {
  # empty vector
  if (!length(x)) 
    return("[]")
  
  # json true/false
  tmp <- ifelse(x, "true", "false")
  
  # logical values can have NA (but not Inf/NaN). Default is to encode as null.
  if (any(missings <- is.na(x))) {
    tmp[missings] <- ifelse(identical(na, "string"), "\"NA\"", "null")
  }
  
  # wrap in container
  if (container) {
    return(paste("[", paste(tmp, collapse = ", "), "]"))
  } else {
    return(tmp)
  }
}) 
