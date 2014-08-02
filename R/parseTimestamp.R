# timestamps can either be: ISO8601 (various formats), R style print, GMT epoch
# ms, or mongo

parseTimestamp <- function(x) {
  UseMethod("parseTimestamp")
}

#' @method parseTimestamp numeric
parseTimestamp.numeric <- function(x) {
  if (any(x < 1e+10) && all(x < 1e+10)) {
    warning("Timestamps seem low. Make sure they are milliseconds and not seconds:\n\n",
      x)
  }
  structure(x/1000, class = c("POSIXct", "POSIXt"))
}

#' @method parseTimestamp character
parseTimestamp.character <- function(x) {
  if (length(na.omit(x)) == 0) {
    return(x)
  }

  patterns <- list(ISODATE = "^(\\d{4})-(\\d{2})-(\\d{2})$", ISOTIME = "^(\\d{4})-(\\d{2})-(\\d{2})(T|\\s)(\\d{2}):(\\d{2})$",
    ISOTIMEUTC = "^(\\d{4})-(\\d{2})-(\\d{2})(T|\\s)(\\d{2}):(\\d{2})Z$", ISOTIMESECONDS = "^(\\d{4})-(\\d{2})-(\\d{2})(T|\\s)(\\d{2}):(\\d{2}):(\\d{2})$",
    ISOTIMESECONDSUTC = "^(\\d{4})-(\\d{2})-(\\d{2})(T|\\s)(\\d{2}):(\\d{2}):(\\d{2})Z$")

  patsums <- sapply(lapply(patterns, regexpr, x), sum, na.rm = TRUE)
  if (max(patsums) == 0) {
    stop("Dates in invalid format:\n", x)
  }
  datepattern <- names(patterns[which.max(patsums)])

  # bit more lenient than iso 8601: we accept both T and space
  substring(x, 11) <- "T"

  # select format
  outtime <- switch(datepattern, ISODATE = strptime(x, "%Y-%m-%d"), ISOTIME = strptime(x,
    "%Y-%m-%dT%H:%M"), ISOTIMEUTC = strptime(x, "%Y-%m-%dT%H:%MZ", tz = "UTC"),
    ISOTIMESECONDS = strptime(x, "%Y-%m-%dT%H:%M:%S"), ISOTIMESECONDSUTC = strptime(x,
      "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"), )

  # convert to POSIXct
  outtime <- as.POSIXct(outtime)

  # return
  return(outtime)
}

#' @method parseTimestamp POSIXt
parseTimestamp.POSIXt <- identity
