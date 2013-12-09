setMethod("asJSON", "numeric", function(x, collapse = TRUE, digits = 5, na = "string", ...) {
  # empty vector
  if (!length(x)) {
    if(collapse) {
      return("[]")
    } else {
      return(character())
    }
  }
  
  # pretty format numbers
  # this is a bit slow
  # tmp <- formatC(x, digits = digits, format = "f", drop0trailing = TRUE)
  
  # See options(scipen) for if and how it switches to scientific notation
  tmp <- as.character(round(x, digits))
  
  # in numeric variables, NA, NaN, Inf are replaced by character strings
  if (any(missings <- which(!is.finite(x)))) {
    if (na %in% c("default", "string")) {
      tmp[missings] <- wrapinquotes(x[missings])
    } else if(identical(na, "null")) {
      tmp[missings] <- "null"
    } else {
      tmp[missings] <- NA_character_
    }
  }
  
  if(collapse){
    collapse(tmp)
  } else {
    tmp
  }
}) 
