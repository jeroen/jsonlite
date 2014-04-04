setMethod("asJSON", "numeric", function(x, collapse = TRUE, digits = 5, na = c("string", "null", "NA"), auto_unbox = FALSE, ...) {
  
  # pretty format numbers, 'drop0trailing' is super slow for some reason
  # tmp <- formatC(x, digits = digits, format = "f", drop0trailing = TRUE)
  
  # This is faster, does not use scientific notation
  # tmp <- sub("\\.0+$", "", sprintf(paste0("%.", digits, "f"), x))
  
  # This is perhaps a bit more natural?
  # See options(scipen) for if and how it switches to scientific notation
  tmp <- as.character(round(x, digits))
  na <- match.arg(na)
  
  # in numeric variables, NA, NaN, Inf are replaced by character strings
  if (any(missings <- which(!is.finite(x)))) {
    if (na %in% c("string")) {
      tmp[missings] <- wrapinquotes(x[missings])
    } else if(identical(na, "null")) {
      tmp[missings] <- "null"
    } else {
      tmp[missings] <- NA_character_
    }
  }
  
  if(isTRUE(auto_unbox) && length(tmp) == 1){
    return(tmp);
  }  
  
  if(collapse){
    collapse(tmp)
  } else {
    tmp
  }
}) 
