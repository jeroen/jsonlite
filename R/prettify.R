#' Prettify adds indentation to a \code{JSON} string; minify removes all indentation/whitespace.
#'
#' @rdname prettify
#' @title Prettify or minify a \code{JSON} string
#' @name prettify, minify
#' @aliases minify prettify
#' @export prettify minify
#' @param txt \code{JSON} string
#' @useDynLib jsonlite R_jsonPrettyPrint R_jsonMiniPrint
#' @examples myjson <- toJSON(cars)
#' cat(myjson)
#' prettify(myjson)
#' minify(myjson)
prettify <- function(txt) {
  txt <- paste(as.character(txt), collapse = "\n")
  enc <- mapEncoding(Encoding(txt))
  ans <- .Call("R_jsonPrettyPrint", txt, enc)
  structure(ans, class="json")
}

#' @rdname prettify
minify <- function(txt) {
  txt <- paste(as.character(txt), collapse = "\n")
  enc <- mapEncoding(Encoding(txt))
  ans <- .Call("R_jsonMiniPrint", txt, enc)
  structure(ans, class="json")
}
