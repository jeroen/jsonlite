null2na <- function(x, unlist = TRUE) {
  if (!length(x)) {
    if (isTRUE(unlist)) {
      return(vector())
    } else {
      return(list())
    }
  }
  # parse explicitly quoted missing values, unless in the case of character vectors
  if (!isTRUE(any(vapply(x, function(y) {
    is.character(y) && !(y %in% c("NA", "Inf", "-Inf", "NaN"))
  }, logical(1))))) {
    missings <- x %in% c("NA", "Inf", "-Inf", "NaN")
    x[missings] <- lapply(x[missings], evaltext)
  }
  
  # parse 'null' values
  x[unlist(sapply(x, is.null))] <- NA
  if (isTRUE(unlist)) {
    return(unlist(x))
  } else {
    return(x)
  }
} 
