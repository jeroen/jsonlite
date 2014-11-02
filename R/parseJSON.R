#' @useDynLib jsonlite R_parse
parseJSON <- function(txt) {
  # Strip of byte order mark as suggested by rfc7159
  if(substr(txt, 1, 1) == "\uFEFF"){
    txt <- substring(txt, 2)
  }
  .Call(R_parse, txt)
}
