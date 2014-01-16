#' @rdname prettify
#' @export
minify <- function(txt) {
  txt <- paste(as.character(txt), collapse = "\n")
  enc <- mapEncoding(Encoding(txt))
  .Call("R_jsonMiniPrint", txt, enc)
} 
