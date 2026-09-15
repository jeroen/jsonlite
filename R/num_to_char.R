#' @useDynLib jsonlite R_num_to_char
num_to_char <- function(x, digits = NA, na_as_string = NA, use_signif = FALSE, always_decimal = FALSE, na_specials = FALSE) {
  if (is.na(digits)) digits <- NA_integer_
  stopifnot(is.numeric(x))
  stopifnot(is.numeric(digits))
  stopifnot(is.logical(na_as_string))
  stopifnot(is.logical(na_specials) && !is.na(na_specials))
  if (na_specials) {
    na_as_string <- FALSE
  }
  .Call(R_num_to_char, x, digits, na_as_string, use_signif, always_decimal, na_specials)
}

#' @useDynLib jsonlite R_integer64_to_char
integer64_to_char <- function(x, na_as_string = TRUE) {
  .Call(R_integer64_to_char, x, na_as_string)
}

num_to_char_R <- function(x, digits = NA, na_as_string = NA, na_specials = FALSE) {
  if (is.na(digits)) digits <- NA_integer_
  stopifnot(is.numeric(x))
  stopifnot(is.numeric(digits))
  stopifnot(is.logical(na_as_string))
  if (!is.integer(x) && !is.null(digits) && !is.na(digits)) {
    x <- round(x, digits)
  }

  #convert to strings
  tmp <- as.character(x)

  # in numeric variables, NA, NaN, Inf are replaced by character strings
  if (any(!is.finite(x))) {
    isna <- which(is.na(x) & !is.nan(x))
    isspec <- which(is.nan(x) | is.infinite(x))
    if (length(isna) > 0L) {
      tmp[isna] <-
        if (is.na(na_as_string)) {
          NA_character_
        } else if (na_as_string) {
          wrapinquotes(x[isna])
        } else {
          "null"
        }
    }
    if (length(isspec)) {
      tmp[isspec] <- if (na_specials) wrapinquotes(x[isspec]) else NA_character_
    }
  }

  #returns a character vector
  return(tmp)
}
