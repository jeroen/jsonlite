#' @rdname fromJSON
toJSON <- function(x, dataframe = c("rows", "columns", "values"), matrix = c("rowmajor", "columnmajor"),
  Date = c("ISO8601", "epoch"), POSIXt = c("string", "ISO8601", "epoch", "mongo"),
  factor = c("string", "integer"), complex = c("string", "list"), raw = c("base64", "hex", "mongo", "int", "js"),
  null = c("list", "null"), na = c("null", "string"), auto_unbox = FALSE, digits = 4,
  pretty = FALSE, force = FALSE, ...) {

  # validate args
  dataframe <- match.arg(dataframe)
  matrix <- match.arg(matrix)
  Date <- match.arg(Date)
  POSIXt <- match.arg(POSIXt)
  factor <- match.arg(factor)
  complex <- match.arg(complex)
  raw <- match.arg(raw)
  null <- match.arg(null)

  # force
  x <- force(x)

  #this is just to check, we keep method-specific defaults
  if(!missing(na)){
    na <- match.arg(na)
  } else {
    na <- NULL
  }

  # default is 2 spaces
  if(isTRUE(pretty)){
    pretty <- 2L
  }

  # Start with indent of 0
  indent <- if(is.numeric(pretty)){
    stopifnot(pretty < 20)
    structure(0L, indent_spaces = as.integer(pretty))
  } else {
    NA_integer_
  }

  # dispatch
  ans <- asJSON(x, dataframe = dataframe, Date = Date, POSIXt = POSIXt, factor = factor,
    complex = complex, raw = raw, matrix = matrix, auto_unbox = auto_unbox, digits = digits,
    na = na, null = null, force = force, indent = indent, ...)
  class(ans) <- "json"
  return(ans)
}

indent_increment <- function(indent){
  spaces <- attr(indent, 'indent_spaces')
  if(length(spaces)){
    indent + spaces
  } else {
    NA_integer_
  }
}
