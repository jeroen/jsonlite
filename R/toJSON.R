#' @rdname fromJSON
toJSON <- function(
  x,
  dataframe = c("rows", "columns", "values"),
  matrix = c("rowmajor", "columnmajor"),
  Date = c("ISO8601", "epoch"),
  POSIXt = c("string", "ISO8601", "epoch", "mongo"),
  factor = c("string", "integer"),
  complex = c("string", "list"),
  raw = c("base64", "hex", "mongo", "int", "js"),
  null = c("list", "null"),
  na = c("null", "string"),
  auto_unbox = FALSE,
  digits = 4,
  pretty = FALSE,
  force = FALSE,
  ...
) {
  # validate args
  dataframe <- match.arg(dataframe, c("rows", "columns", "values"))
  matrix <- match.arg(matrix, c("rowmajor", "columnmajor"))
  Date <- match.arg(Date, c("ISO8601", "epoch"))
  POSIXt <- match.arg(POSIXt, c("string", "ISO8601", "epoch", "mongo"))
  factor <- match.arg(factor, c("string", "integer"))
  complex <- match.arg(complex, c("string", "list"))
  raw <- match.arg(raw, c("base64", "hex", "mongo", "int", "js"))
  null <- match.arg(null, c("list", "null"))

  # Temp workaround for 'mongopipe' unit test
  # if (pretty == 2 && identical(x, list()) && identical(Sys.getenv('TESTTHAT_PKG'), 'mongopipe')) {
  #  return('[\n\n]')
  # }

  # force
  x <- force(x)

  #this is just to check, we keep method-specific defaults
  if (!missing(na)) {
    na <- match.arg(na, c("null", "string"))
  } else {
    na <- NULL
  }

  # dispatch
  indent <- indent_init(pretty)
  ans <- asJSON(x, dataframe = dataframe, Date = Date, POSIXt = POSIXt, factor = factor, complex = complex, raw = raw, matrix = matrix, auto_unbox = auto_unbox, digits = digits, na = na, null = null, force = force, indent = indent, ...)
  class(ans) <- "json"
  return(ans)
}

indent_init <- function(pretty) {
  # default is 2 spaces
  if (isTRUE(pretty)) {
    pretty <- 2L
  }

  # Start with indent of 0
  if (is.numeric(pretty)) {
    stopifnot(abs(pretty) < 20)
    structure(0L, indent_spaces = as.integer(pretty))
  } else {
    NA_integer_
  }
}

indent_increment <- function(indent) {
  indent_spaces <- attr(indent, 'indent_spaces')
  if (length(indent_spaces)) {
    indent + abs(indent_spaces)
  } else {
    NA_integer_
  }
}
