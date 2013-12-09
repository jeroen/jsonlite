setMethod("asJSON", "complex", function(x, digits = 5, collapse = TRUE, complex = c("string", 
  "list"), na = c("string", "null", "NA", "default"), ...) {
  
  # validate
  na <- match.arg(na);
  complex <- match.arg(complex)
  
  # empty vector
  if (!length(x)) {
    if(collapse) {
      return("[]")
    } else {
      return(character())
    }
  }
  
  #turn into strings
  if (complex == "string") {
    #default NA is "NA"
    mystring <- prettyNum(x = x, digits = digits)
    if (any(missings <- which(!is.finite(x)))){
      if (na %in% c("null", "NA")) {
        mystring[missings] <- NA_character_;
      }
    }
    asJSON(mystring, collapse = collapse, na = na, ...)
  } else {
    asJSON(list(real = Re(x), imaginary = Im(x)), na = na, ...)
  }
}) 
