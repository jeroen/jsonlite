setMethod("asJSON", "POSIXt", function(x, POSIXt = c("string", "ISO8601", "epoch",
  "mongo"), UTC = FALSE, digits, time_format = NULL, always_decimal = FALSE,
  na = c("null", "string", "NA"), ...) {
  # note: UTC argument doesn't seem to be working consistently maybe use ?format
  # instead of ?as.character

  # Validate
  POSIXt <- match.arg(POSIXt)

  # Encode based on a schema
  if (POSIXt == "mongo") {
    if (inherits(x, "POSIXlt")) {
      x <- as.POSIXct(x)
    }
    df <- data.frame("$date" = floor(unclass(x) * 1000), check.names = FALSE)
    if(inherits(x, "scalar"))
      class(df) <- c("scalar", class(df))
    tmp <- asJSON(df, digits = NA, always_decimal = FALSE, ...)
    if (any(missings <- which(is.na(x)))) {
      na <- match.arg(na)
      if (na %in% c("null")) {
        tmp[missings] <- "null"
      } else if(na %in% "string") {
        tmp[missings] <- "\"NA\""
      } else {
        tmp[missings] <- NA_character_
      }
    }
    return(tmp)
  }

  # Epoch millis
  if (POSIXt == "epoch") {
    return(asJSON(floor(unclass(as.POSIXct(x)) * 1000), digits = digits, always_decimal = FALSE, na = na, ...))
  }

  # Strings
  if(is.null(time_format)){
    time_format <- if(POSIXt == "string"){
      ""
    } else if(isTRUE(UTC)){
      "%Y-%m-%dT%H:%M:%SZ"
    } else {
      "%Y-%m-%dT%H:%M:%S"
    }
  }

  if (isTRUE(UTC)) {
    asJSON(as.character(x, format = time_format, tz = "UTC"), na = na, ...)
  } else {
    asJSON(as.character(x, format = time_format), na = na, ...)
  }
})
