#' @rdname toJSON
#' @export
toJSON <- function(x, dataframe = c("rows", "columns"), Date = c("ISO8601", "epoch"), 
  POSIXt = c("string", "ISO8601", "epoch", "mongo"), factor = c("string", "integer"), 
  complex = c("string", "list"), raw = c("base64", "hex", "mongo"), na=c("null", "string"), 
  digits = 2, pretty = FALSE, ...) {
  
  # validate args
  dataframe <- match.arg(dataframe)
  Date <- match.arg(Date)
  POSIXt <- match.arg(POSIXt)
  factor <- match.arg(factor)
  complex <- match.arg(complex)
  raw <- match.arg(raw)
  
  #this is just to check, we keep method-specific defaults
  if(!missing(na)){
    na <- match.arg(na)
  } else {
    na <- NULL
  }
  
  # force
  x <- force(x)
  
  # dispatch
  ans <- asJSON(x, dataframe = dataframe, Date = Date, POSIXt = POSIXt, factor = factor, 
    complex = complex, raw = raw, digits = digits, na = na, ...)
  
  #prettify
  if (isTRUE(pretty)) {
    return(prettify(ans))
  } else {
    return(ans)
  }
}

# maps encoding name to integer
mapEncoding <- function(encoding) {
  if (is.na(encoding)) {
    return(0L)
  }
  
  codes <- c(unknown = 0L, native = 0L, utf8 = 1L, `utf-8` = 1L, latin1 = 2L, bytes = 3L, 
    symbol = 5L, any = 99L)
  
  enc <- pmatch(tolower(encoding), names(codes))
  if (is.na(enc)) {
    stop("unrecognized encoding:", encoding)
  }
  return(codes[enc])
} 
