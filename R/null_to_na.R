#' @useDynLib jsonlite C_null_to_na
null_to_na <- function(x, naStrings) {
  .Call(C_null_to_na, x, naStrings)
}

#' @useDynLib jsonlite C_is_datelist
is_datelist <- function(x){
  .Call(C_is_datelist, x)
}
