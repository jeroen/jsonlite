#' Export to MongoDB
#'
#' This function will be deprecated. Please use stream_out instead.
#'
#' This function will be deprecated. Please use stream_out instead.
#'
#' @param x a dataframe
#' @param array if output should be an array. See details.
#' @param POSIXt passed on to \code{\link{toJSON}}
#' @param raw passed on to \code{\link{toJSON}}
#' @param ... other arguments for \code{\link{toJSON}}
#' @export
toMongo <- function(x, array = FALSE, POSIXt = "mongo", raw = "mongo", ...) {
  message("This function will be deprecated. Please use stream_out instead.")
  if (!is.data.frame(x)) {
    stop("toMongo only exports dataframes.")
  }
  asJSON(x, POSIXt = POSIXt, raw = raw, collapse = array, ...)
}
