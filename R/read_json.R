#' Read/write JSON
#'
#' Convenience wrappers around \link{toJSON} and \link{fromJSON} to read and
#' write directly to/from disk.
#'
#' @rdname read_json
#' @export
#' @param path file on disk
#' @param simplifyVector simplifies nested lists into vectors and data frames. See \link{fromJSON}.
#' @examples tmp <- tempfile()
#' write_json(iris, tmp)
#'
#' # Nested lists
#' read_json(tmp)
#'
#' # A data frame
#' read_json(tmp, simplifyVector = TRUE)
read_json <- function(path, simplifyVector = FALSE, ...){
  fromJSON(file(path), simplifyVector = simplifyVector, ...)
}

#' @rdname read_json
#' @export
#' @param x an object to be serialized to JSON
#' @param ... additional arguments passed to \link{toJSON} or \link{fromJSON}
write_json <- function(x, path, ...) {
  json <- jsonlite::toJSON(x, ...)
  writeLines(json, path)
}
