#' Encode/decode base64
#'
#' Simple in-memory base64 encoder and decoder. Used internally for converting
#' raw vectors to text. Interchangable with encoder from \code{base64enc} or
#' \code{openssl} package.
#'
#' @param input string or raw vector to be encoded/decoded
#' @export
#' @rdname base64
#' @name base64
#' @useDynLib jsonlite R_base64_decode
base64_decode <- function(input) {
  if(is.character(input)){
    input <- charToRaw(paste(input, collapse = "\n"))
  }
  stopifnot(is.raw(input))
  .Call(R_base64_decode, input)
}

#' @export
#' @rdname base64
#' @useDynLib jsonlite R_base64_encode
base64_encode <- function(input) {
  if(is.character(input)){
    input <- charToRaw(paste(input, collapse = "\n"))
  }
  stopifnot(is.raw(input))
  buf <- .Call(R_base64_encode, input)
  rawToChar(buf)
}
