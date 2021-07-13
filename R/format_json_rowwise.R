#' Convert a data.frame rowwise to JSON
#'
#' @inheritParams toJSON
#'
#' @return A json vector of length equal to the number of rows of the input data.frame.
#' @examples
#' format_json_rowwise(mtcars[1:3, ])
#' \dontrun{
#' dplyr::transmute(
#'   iris,
#'   Species,
#'   json_col = format_json_rowwise(dplyr::tibble(Sepal.Length, Sepal.Width))
#' )
#' }
format_json_rowwise <- function(df, matrix = c("rowmajor", "columnmajor"),
  Date = c("ISO8601", "epoch"), POSIXt = c("string", "ISO8601", "epoch", "mongo"),
  factor = c("string", "integer"), complex = c("string", "list"), raw = c("base64", "hex", "mongo"),
  null = c("list", "null"), na = c("null", "string"), auto_unbox = FALSE, digits = 4,
  pretty = FALSE, force = FALSE, json_verbatim = TRUE, ...) {
  if (!is.data.frame(df)) {
    stop("x must be a tbl")
  }


  # workaround so that json_verbatim actually works
  `[.json` <- function(x, i) {
    structure(NextMethod("["), class = c("json", "character"))
  }

  tmp_file <- tempfile()
  filecon <- file(tmp_file, "a+")
  on.exit({
    close(filecon)
    unlink(tmp_file)
  })
  stream_out(
    df, con = filecon,
    verbose = FALSE,
    Date = Date, POSIXt = POSIXt, factor = factor,
    complex = complex, raw = raw, matrix = matrix, auto_unbox = auto_unbox, digits = digits,
    na = na, null = null, force = force, indent = indent, json_verbatim = json_verbatim,
    ...
  )

  as_json(readLines(filecon))
}


as_json <- function(x) {
  vctrs::new_vctr(x, class = c("json", "character"))
}

#' @export
vec_ptype2.json <- function(x, y, ...) UseMethod("vec_ptype2.json", y)
#' @export
vec_ptype2.json.character <- function(x, y, ...) {
  character()
}
#' @export
vec_ptype2.character.json <- function(x, y, ...) {
  structure(character(), class = c("json", "character"))
}
#' @export
vec_ptype2.json.json <- function(x, y, ...) {
  structure(character(), class = c("json", "character"))
}
#' @export
vec_ptype2.json.default <- function(x, y, ..., x_arg = "x", y_arg = "y") {
  vctrs::stop_incompatible_type(x, y, x_arg = x_arg, y_arg = y_arg)
}


#' @export
pillar_shaft.json <- function(x, ...) {
  out <- noquote(x)
  pillar::new_pillar_shaft_simple(out, align = "right")
}
