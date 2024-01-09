#' @import methods
setMethod("asJSON", "ANY", function(x, force = FALSE, ...) {
  if (isS4(x) && !is(x, "classRepresentation")) {
    if (isTRUE(force)) {
      return(asJSON(attributes(x), force = force, ...))
    } else {
      stop("No method for S4 class:", class(x))
    }
  }
  
  ## walk the s3 class chain (if any):
  if (length(class(x)) > 1) {
    for (cls in class(x)[-1]) {
      f <- getMethod("asJSON", cls, optional = TRUE)
      if (!is.null(f)) return(f(x, ...))
    }
  }
  
  ## fallback class:
  if (isTRUE(force)) {
    f <-
      tryCatch({
        getMethod("asJSON", class(unclass(x))[1], optional = TRUE)  ## unclass() can err, hence tryCatch()
      }, error = function(e) NULL)
    if (!is.null(f)) return(f(x, ...))
  }

  msg <- sprintf("No method asJSON S3 class: %s", paste0(class(x), collapse = ","))
  
  ## final fallback -- encode NULL and warn:
  if (isTRUE(force)) {
    warning(msg)
    return(asJSON(NULL))
  }
  
  ## give up.
  stop(msg)
})

