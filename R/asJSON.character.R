setMethod("asJSON", "character", function(x, collapse = TRUE, na = c("null", "string", "NA"), ...) {
  
  # vectorized escaping
  tmp <- deparse_vector(x)
  
  # validate NA
  if (any(missings <- which(is.na(x)))) {
    na <- match.arg(na)
    if (na %in% c("null")) {
      tmp[missings] <- "null"
    } else if(na %in% "string") {
      tmp[missings] <- "\"NA\""
    } else {
      tmp[missings] <- NA_character_
    }
  }
  
  # this is almost always true, except for class 'scalar'
  if (isTRUE(collapse)) {
    collapse(tmp)
  } else {
    tmp
  }
}) 
