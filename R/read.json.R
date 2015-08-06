#' Wrapper around fromJSON.
#'
#' @param file a JSON file
#' @param ... arguments passed on to \code{\link{fromJSON}}
#' @examples
#' \dontrun{
#'
#' data <- read.json(file="data.json")
#' }
#' @export
read.json <- function(file = "", ...) {
  data <- fromJSON(txt = file, ...)
  return(data)
}
