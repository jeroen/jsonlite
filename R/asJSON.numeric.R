setMethod("asJSON", "numeric", function(x, collapse = TRUE, digits = 5, na = c("string", "null", "NA"), auto_unbox = FALSE, ...) {
  
  # pretty format numbers, 'drop0trailing' is super slow for some reason
  # tmp <- formatC(x, digits = digits, format = "f", drop0trailing = TRUE)
  
  # This is faster, does not use scientific notation
  # tmp <- sub("\\.0+$", "", sprintf(paste0("%.", digits, "f"), x))
  
  # This is perhaps a bit more natural?
  # See options(scipen) for if and how it switches to scientific notation
  # tmp <- as.character(round(x, digits))

  # The problem with round is that it'll leave lots of digits on long numbers
  # but very few on small ones, so varying relative precision
  # BUT, just using formatC will round large integers more than we want
  # the following ensures that large integers retain their precision
  #    [using gsub() to get rid of leading spaces]
  tmp <- character(length(x))
  above <- (is.na(x) | x >= 10^digits)
  tmp[!above] <- gsub(" ", "", formatC(x[!above], digits=digits))
  tmp[above] <- as.character(round(x[above]))

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
