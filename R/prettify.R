#' Prettify adds indentation to a \code{JSON} string; minify removes all indentation/whitespace.
#'
#' @rdname prettify
#' @title Prettify or minify a \code{JSON} string
#' @name prettify, minify
#' @aliases minify prettify
#' @export prettify minify
#' @param txt \code{JSON} string
#' @useDynLib jsonlite R_reformat
#' @examples myjson <- toJSON(cars)
#' cat(myjson)
#' prettify(myjson)
#' minify(myjson)
prettify <- function(txt) {
  txt <- paste(as.character(txt), collapse = "\n")
  ans <- reformat(txt, TRUE)
  class(ans) <- "json"
  ans
}

#' @rdname prettify
minify <- function(txt) {
  txt <- paste(as.character(txt), collapse = "\n")
  ans <- reformat(txt, FALSE)
  class(ans) <- "json"
  ans
}

reformat <- function(x, pretty){
  out <- .Call(R_reformat, x, pretty);
  if(out[[1]] == 0) {
    return(out[[2]])
  } else {
    stop(out[[2]], call.=FALSE)
  }
}
