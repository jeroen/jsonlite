#' Prettify adds indentation to a JSON string; minify removes all indentation/whitespace.
#'
#' @rdname prettify
#' @title Prettify or minify a JSON string
#' @name prettify, minify
#' @aliases minify prettify
#' @export prettify minify
#' @param txt JSON string
#' @useDynLib jsonlite R_reformat
#' @examples myjson <- toJSON(cars)
#' cat(myjson)
#' prettify(myjson)
#' minify(myjson)
prettify <- function(txt) {
  txt <- paste(as.character(txt), collapse = "\n")
  ans <- reformat(txt, TRUE)
}

#' @rdname prettify
minify <- function(txt) {
  txt <- paste(as.character(txt), collapse = "\n")
  ans <- reformat(txt, FALSE)
}

reformat <- function(x, pretty){
  out <- .Call(R_reformat, x, pretty);
  if(out[[1]] == 0) {
    return(out[[2]])
  } else {
    stop(out[[2]], call.=FALSE)
  }
}
