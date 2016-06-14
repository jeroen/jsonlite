#' @useDynLib jsonlite R_base64_decode
base64_decode <- function(input) {
  if(is.character(input)){
    input <- charToRaw(paste(input, collapse = "\n"))
  }
  stopifnot(is.raw(input))
  .Call(R_base64_decode, input)
}


#' @useDynLib jsonlite R_base64_encode
base64_encode <- function(input) {
  if(is.character(input)){
    input <- charToRaw(paste(input, collapse = "\n"))
  }
  stopifnot(is.raw(input))
  buf <- .Call(R_base64_encode, input)
  rawToChar(buf)
}
