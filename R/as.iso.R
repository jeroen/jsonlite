as.iso <- function(x, ...) {
  UseMethod("as.iso")
}

#' @method as.iso Date
as.iso.Date <- function(x, ...) {
  as.character(x)
}

#' @method as.iso POSIXt
as.iso.POSIXt <- function(x, UTC = FALSE, format = NULL, ...) {
  if(is.null(format)){
    format <- ifelse(isTRUE(UTC), "%Y-%m-%dT%H:%M:%SZ", "%Y-%m-%dT%H:%M:%S")
  }
  if (isTRUE(UTC)) {
    as.character(x, format = format, tz = "UTC")
  } else {
    as.character(x, format = format)
  }
}
