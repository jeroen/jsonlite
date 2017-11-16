setMethod("asJSON", "difftime", function(x, difftime = c("string", "epoch"), always_decimal = FALSE, ...) {

  # Validate argument
  difftime <- match.arg(difftime)

  # select a schema
  output <- switch(difftime,
                   string = format(x),
                   epoch = {
                     value <- unclass(x)
                     units <- attr(x, "units")
                     if (units == "secs"){
                       values <- value[1]
                     } else if(units == "mins") {
                       value <- value[1] * 60
                     } else if(units == "hours") {
                       value <- value[1] * 3600
                     } else if(units == "days") {
                       value <- value[1] * 86400
                     }
                   },
                   default = stop("Invalid argument for 'difftime':", difftime)
  )

  # Dispatch to character encoding
  asJSON(output, always_decimal = FALSE, ...)
})
