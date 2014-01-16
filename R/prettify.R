#' Prettify or minify a JSON string.
#' 
#' Prettify adds indentation to a JSON string; minify removes all indentation/whitespace.
#' 
#' @param txt JSON string
#' @aliases minify
#' @export prettify
#' @export minify
#' @title prettify, minify
#' @examples myjson <- toJSON(cars)
#' cat(myjson)
#' cat(prettify(myjson))
#' cat(minify(myjson))
prettify <- function(txt) {
  txt <- paste(as.character(txt), collapse = "\n")
  enc <- mapEncoding(Encoding(txt))
  .Call("R_jsonPrettyPrint", txt, enc)
} 
