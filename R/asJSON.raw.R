setMethod("asJSON", "raw", function(x, raw = c("base64", "hex", "mongo"), ...) {

  # validate
  raw <- match.arg(raw)

  # encode based on schema
  if (raw == "mongo") {
    return(asJSON(list(`$binary` = as.scalar(base64_encode(x)), `$type` = as.scalar("5"))))
  } else if (raw == "hex") {
    return(asJSON(as.character.hexmode(x), ...))
  } else {
    # no as scalar here!
    return(asJSON(base64_encode(x), ...))
  }
})
