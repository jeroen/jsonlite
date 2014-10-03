#' @useDynLib jsonlite R_num_to_char
num_to_char <- function(x, digits = 4, na_as_string = NA){
  stopifnot(is.numeric(x))
  stopifnot(is.numeric(digits))
  stopifnot(is.logical(na_as_string))
  .Call(R_num_to_char, x, digits, na_as_string)
}

num_to_char_R <- function(x, digits = 4, na_as_string = NA){
  stopifnot(is.numeric(x))
  stopifnot(is.numeric(digits))
  stopifnot(is.logical(na_as_string))
  if(!is.integer(x)){
    x <- round(x, digits)
  }

  #convert to strings
  tmp <- as.character(x)

  # in numeric variables, NA, NaN, Inf are replaced by character strings
  if (any(missings <- which(!is.finite(x)))) {
    if(is.na(na_as_string)){
      tmp[missings] <- NA_character_;
    } else if(na_as_string){
      tmp[missings] <- wrapinquotes(x[missings])
    } else {
      tmp[missings] <- "null"
    }
  }

  #returns a character vector
  return(tmp)
}
