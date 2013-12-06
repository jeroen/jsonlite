setMethod("asJSON", "numeric", function(x, container = TRUE, digits = 5, na = "string", 
  ...) {
  # empty vector
  if (!length(x)) {
    return("[]")
  }
  
  # pretty format numbers
  tmp <- formatC(x, digits = digits, format = "f", drop0trailing = TRUE)
  
  # in numeric variables, NA, NaN, Inf are replaced by character strings
  if (any(missings <- which(!is.finite(x)))) {
    if (na %in% c("default", "string")) {
      tmp[missings] <- wrapinquotes(x[missings])
    } else {
      tmp[missings] <- "null"
    }
  }
  
  if(!container){
    return(paste0(tmp, collapse = ", "))
  } else {
    return(paste0("[ ", paste0(tmp, collapse = ", "), " ]"))
  }
}) 
