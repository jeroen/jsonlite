setMethod("asJSON", "character", function(x, collapse = TRUE, na = c("null", "string", "NA"), auto_unbox = FALSE, ...) {

  # vectorized escaping
  tmp <- deparse_vector(x)

  # this was used with deparse_vector_old
  #if(identical(Encoding(x), "UTF-8")){
  #  if(!grepl("UTF", Sys.getlocale("LC_CTYPE"), ignore.case=TRUE)){
  #    tmp <- utf8conv(tmp);
  #  }
  #}

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

  if(isTRUE(auto_unbox) && length(tmp) == 1){
    return(tmp);
  }

  # this is almost always true, except for class 'scalar'
  if (isTRUE(collapse)) {
    collapse(tmp)
  } else {
    tmp
  }
})
