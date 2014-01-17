#' Prettify adds indentation to a \code{JSON} string; minify removes all indentation/whitespace.
#' 
#' @name prettify-minify
#' @aliases minify prettify
#' @rdname prettify
#' @title Prettify or minify a \code{JSON} string
#' @export prettify minify
#' @param txt JSON string
#' @examples myjson <- toJSON(cars)
#' cat(myjson)
#' cat(prettify(myjson))
#' cat(minify(myjson))
prettify <- function(txt) {
  txt <- paste(as.character(txt), collapse = "\n")
  enc <- mapEncoding(Encoding(txt))
  .Call("R_jsonPrettyPrint", txt, enc)
} 
