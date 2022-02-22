#' Gzipped JSON
#'
#' Wrapper to generate and parse gzipped JSON, in order to save some disk or
#' network space. This is mainly effective for larger json objects with many
#' repeated keys, as is common in serialized data frames.
#'
#' @param x R data object to be converted to JSON
#' @param ... passed down to [toJSON] or [fromJSON]
#' @export
#' @name gzjson
#' @rdname gzjson
#' @examples str <- as_gzjson_b64(iris[1:5,])
#' cat(str)
#' parse_gzjson_b64(str)
as_gzjson_raw <- function(x, ...){
  json <- toJSON(x = x, ...)
  memCompress(json, 'gzip')
}

#' @export
#' @rdname gzjson
#' @param buf  raw vector with gzip compressed data
#' @param simplifyVector passed to [fromJSON]
parse_gzjson_raw <- function(buf, simplifyVector = TRUE, ...){
  json <- rawToChar(memDecompress(buf, 'gzip'))
  parse_json(json, simplifyVector = simplifyVector, ...)
}

#' @export
#' @rdname gzjson
as_gzjson_b64 <- function(x, ...){
  buf <- as_gzjson_raw(x = x, ...)
  base64_enc(buf)
}

#' @export
#' @rdname gzjson
#' @param b64 base64 encoded string containing gzipped json data
parse_gzjson_b64 <- function(b64){
  parse_gzjson_raw(base64_dec(b64))
}
