setMethod("asJSON", "complex", function(x, digits = 5, collapse = TRUE, complex = c("string", "list"), na = c("string", "null", "NA"), oldna = NULL, ...) {
  # validate
  na <- match.arg(na)
  complex <- match.arg(complex)

  #turn into strings
  if (complex == "string") {
    finite <- is.finite(x)
    if (isTRUE(is.na(digits))) {
      # Format components independently to retain all double precision.
      mystring <- structure(character(length(x)), names = names(x))
      mystring[finite] <- sprintf("%.17g%+.17gi", Re(x[finite]), Im(x[finite]))
      mystring[!finite] <- prettyNum(x = x[!finite], digits = 17L)
    } else {
      mystring <- prettyNum(x = x, digits = digits)
    }
    #default NA is "NA"
    if (na %in% c("null", "NA")) {
      mystring[!finite] <- NA_character_
    }
    asJSON(mystring, collapse = collapse, na = na, ...)
  } else {
    if (na == "NA") {
      na <- oldna
    }
    asJSON(list(real = Re(x), imaginary = Im(x)), na = na, digits = digits, ...)
  }
})
