setMethod("asJSON", "complex", function(x, digits = 5, collapse = TRUE, complex = c("string", 
  "list"), na = c("string", "null", "NA", "default"), ...) {
  
  # validate
  na <- match.arg(na);
  complex <- match.arg(complex)
  
  # empty vector
  if (!length(x)) {
    return("[]")
  }
  
  #turn into strings
  if (complex == "string") {
    #default NA is "NA"
    mystring <- prettyNum(x = x, digits = digits)
    if (any(missings <- which(!is.finite(x)))){
      if (na %in% c("null", "NA")) {
        mystring[missings] <- NA;
      }
    }
    return(asJSON(mystring, collapse = collapse, na = na, ...))
  } else {
    mylist <- list(real = Re(x), imaginary = Im(x))
    
    # this is a bit of a hack if collapse is false, this is length 1 vector so we
    # have to actually apply this so the real and imaginary elements of the list
    if (!collapse) {
      mylist <- lapply(mylist, as.scalar)
    }
    
    # return
    return(asJSON(mylist, na = na, ...))
  }
}) 
