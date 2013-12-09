setMethod("asJSON", "numeric", function(x, collapse = TRUE, digits = 5, na = "string", ...) {
  
  # pretty format numbers, 'drop0trailing' is super slow for some reason
  # tmp <- formatC(x, digits = digits, format = "f", drop0trailing = TRUE)
  
  # This is faster, does not use scientific notation
  # tmp <- sub("\\.0+$", "", sprintf(paste0("%.", digits, "f"), x))
  
  # This is perhaps a bit more natural?
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
