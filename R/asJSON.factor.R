setMethod("asJSON", "factor", function(x, factor = c("string", "integer"), ...,
  keep_vec_names = FALSE) {

  # validate
  factor <- match.arg(factor)

  # dispatch
  if (factor == "integer") {
    # encode factor as enum
    asJSON(unclass(x), ...)

  } else {
    xc <- as.character(x)

    if (isTRUE(keep_vec_names) && !is.null(names(x))) {
      # as.character drops names, so we need to explicitly keep them
      names(xc) <- names(x)
    }

    # encode as strings
    asJSON(xc, keep_vec_names = keep_vec_names, ...)
  }
})
