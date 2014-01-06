#' Minify JSON
#' 
#' Remove whitespace and indentation from a JSON string.
#' 
#' @param txt JSON string
#' @export
#' @family prettify
minify <- function(txt) {
  txt <- paste(as.character(txt), collapse = "\n")
  enc <- mapEncoding(Encoding(txt))
  .Call("R_jsonMiniPrint", txt, enc)
} 
