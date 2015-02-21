parseJSON <- function(txt) {
  if(is(txt, "connection")){
    parse_con(txt)
  } else {
    parse_string(txt)
  }
}

#' @useDynLib jsonlite R_parse
parse_string <- function(txt){
  if (length(txt) > 1) {
    txt <- paste(txt, collapse = "\n")
  }
  .Call(R_parse, txt)
}
