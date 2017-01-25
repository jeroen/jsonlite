#' @useDynLib jsonlite C_escape_chars
deparse_vector <- function(x, escape_solidus = FALSE) {
  .Call(C_escape_chars, x, escape_solidus)
}
