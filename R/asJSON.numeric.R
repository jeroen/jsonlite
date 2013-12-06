setMethod("asJSON", "numeric", function(x, container = TRUE, digits = 5, na = "string", 
  ...) {
  # empty vector
  if (!length(x)) {
    return("[]")
  }
  
  # pretty format numbers
  tmp <- trim(formatC(x, digits = digits, format = "f", drop0trailing = TRUE))
  
  # in numeric variables, NA, NaN, Inf are replaced by character strings
  if (any(missings <- !is.finite(x))) {
    if (na %in% c("default", "string")) {
      tmp[missings] <- wrapinquotes(tmp[missings])
    } else {
      tmp[missings] <- "null"
    }
  }
  
  tmp <- paste(tmp, collapse = ", ")
  
  if (container) {
    tmp <- paste("[", tmp, "]")
  }
  return(tmp)
}) 
