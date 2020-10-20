#' Encode/decode base64
#'
#' Simple in-memory base64 encoder and decoder. Used internally for converting
#' raw vectors to text. Interchangeable with encoder from \code{base64enc} or
#' \code{openssl} package.
#'
#' @param input string or raw vector to be encoded/decoded
#' @export
#' @rdname base64
#' @name base64
#' @useDynLib jsonlite R_base64_decode
#' @examples str <- base64_enc(serialize(iris, NULL))
#' out <- unserialize(base64_dec(str))
#' stopifnot(identical(out, iris))
base64_dec <- function(input) {
  if(is.character(input)){
    input <- charToRaw(paste(input, collapse = "\n"))
  }
  stopifnot(is.raw(input))
  .Call(R_base64_decode, input)
}

#' @export
#' @rdname base64
#' @useDynLib jsonlite R_base64_encode
base64_enc <- function(input) {
  if(is.null(input))
    return(NA_character_)
  if(is.character(input)){
    input <- charToRaw(paste(input, collapse = "\n"))
  }
  stopifnot(is.raw(input))
  .Call(R_base64_encode, input)
}
