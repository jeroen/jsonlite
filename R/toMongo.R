#' Export to MongoDB
#' 
#' Exports a dataframe to a format that can be imported with the 
#' \code{mongoimport} command line tool included with MongoDB.
#' 
#' By default \code{mongoimport} expects a datafile in which every line is a record 
#' in the collection. Hence the complete output is not valid \code{JSON} itself.
#' Alternatively, if \code{array=TRUE} the output will be wrapped a \code{JSON} array. 
#' When using the latter, we need to pass \code{--jsonArray} to \code{mongoimport}.
#' 
#' @param x a dataframe
#' @param array if output should be an array. See details.
#' @param POSIXt passed on to \code{\link{toJSON}}
#' @param raw passed on to \code{\link{toJSON}}
#' @param ... other arguments for \code{\link{toJSON}}
#' @export
toMongo <- function(x, array = FALSE, POSIXt = "mongo", raw = "mongo", ...) {
  if (!is.data.frame(x)) {
    stop("toMongo only exports dataframes.")
  }
  asJSON(x, POSIXt = POSIXt, raw = raw, collapse = array, ...)
} 
