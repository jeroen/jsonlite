setMethod("asJSON", "logical", function(x, collapse = TRUE, na = c("null", "string", "NA", "default"), ...) {
  # validate arg
  na <- match.arg(na)
  
  # empty vector
  if (!length(x)){
    return("[]")
  }
  
  # json true/false
  tmp <- ifelse(x, "true", "false")
  
  # replace missing values, unless na="NA"
  if(!identical(na, "NA")){
    # logical values can have NA (but not Inf/NaN). Default is to encode as null.
    if (any(missings <- which(is.na(x)))) {
      tmp[missings] <- ifelse(identical(na, "string"), "\"NA\"", "null")
    }
  }
  
  # collapse it
  if(collapse) {
    collapse(tmp)
  } else {
    tmp
  }
}) 
