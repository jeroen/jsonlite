#' Wrapper around toJSON.
#'
#' @param x the object to be encoded
#' @param file a JSON file
#' @param ... arguments passed on to \code{\link{toJSON}}
#' @examples
#' \dontrun{
#'
#' write.json(x = data, file="data.json")
#' }
#' @export
write.json <- function(x, file = "", ...) {
  x.json <- toJSON(x, ...)
  write(x.json, file=file)
}
