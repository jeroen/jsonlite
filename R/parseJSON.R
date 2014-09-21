#' @useDynLib jsonlite R_parse
parseJSON <- function(txt) {
  .Call(R_parse, txt)
}
