#' @rdname fromJSON
toJSON <- function(x, dataframe = c("rows", "columns", "values"), matrix = c("rowmajor", "columnmajor"),
  Date = c("ISO8601", "epoch"), POSIXt = c("string", "ISO8601", "epoch", "mongo"),
  factor = c("string", "integer"), complex = c("string", "list"), raw = c("base64", "hex", "mongo"),
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

  # edge case because 'null' in itself is not valid json
  if(is.null(x)){
    null <- "list"
  }

  #this is just to check, we keep method-specific defaults
  if(!missing(na)){
    na <- match.arg(na)
  } else {
    na <- NULL
  }

  indent <- if (isTRUE(pretty)) 0L else NA_integer_

  # dispatch
  ans <- asJSON(x, dataframe = dataframe, Date = Date, POSIXt = POSIXt, factor = factor,
    complex = complex, raw = raw, matrix = matrix, auto_unbox = auto_unbox, digits = digits,
    na = na, null = null, force = force, indent = indent, ...)

  #prettify with yajl
  if(is.numeric(pretty)) {
    prettify(ans, pretty)
  } else {
    class(ans) <- "json"
    return(ans)
  }
}

View <- function(x, title, ...){

  if(missing(title)) {
    title <- deparse(substitute(x))[1]
  }

  #workaround for View() not supporting nested data frames
  #note that utils::View also does as.data.frame. We just add format.data.frame.
  x <- format.data.frame(as.data.frame(x))

  #In rstudio, utils::View is different from get("View", "package:utils")
  get("View", "package:utils")(x, title, ...)
}
