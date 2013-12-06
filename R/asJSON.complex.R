setMethod("asJSON", "complex", function(x, digits = 5, container = TRUE, complex = c("string", 
  "list"), na = "string", ...) {
  # validate
  complex <- match.arg(complex)
  
  # empty vector
  if (!length(x)) 
    return("[]")
  
  if (complex == "string") {
    mystring <- prettyNum(x = x, digits = digits)
    if (na == "null") {
      mystring[is.na(x)] <- NA
    }
    
    if (!container) {
      mystring <- as.scalar(mystring)
    }
    return(asJSON(mystring, na = "null", ...))
  } else {
    mylist <- list(real = Re(x), imaginary = Im(x))
    
    # this is a bit of a hack if container is false, this is length 1 vector so we
    # have to actually apply this so the real and imaginary elements of the list
    if (!container) {
      mylist <- lapply(mylist, as.scalar)
    }
    
    # return
    return(asJSON(mylist, na = na, ...))
  }
}) 
