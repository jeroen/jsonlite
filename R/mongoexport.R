#' Export to MongoDB
#' 
#' Exports a dataframe to a format that can be imported with 'mongoimport'.
#' 
#' By default mongoimport expects a datafile in which every line is a record 
#' in the collection. Hence the complete output is not valid json itself.
#' Alternatively, if array=TRUE the output will be wrapped a JSON array. 
#' When using the latter, we need to pass --jsonArray to mongoimport.
#' 
#' @param x a dataframe
#' @param array if output should be an array. See details. 
#' @param ... args passed on to asJSON
#' @export
toMongo <- function(x, array = FALSE, ...) {
  if (!is.data.frame(x)) {
    stop("toMongo only exports dataframes.")
  }
  
  asJSON(x, POSIXt = "mongo", raw = "mongo", collapse = array, ...)
} 
