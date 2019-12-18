setMethod("asJSON", "raw", function(x, raw = c("base64", "hex", "mongo", "int", "js"), ...) {

  # validate
  raw <- match.arg(raw)

  # encode based on schema
  if (raw == "mongo") {
    type <- ifelse(length(attr(x, "type")), attr(x, "type"), 5)
    return(asJSON(list(`$binary` = as.scalar(base64_enc(x)), `$type` = as.scalar(as.character(type)))))
  } else if (raw == "hex") {
    return(asJSON(as.character.hexmode(x), ...))
  } else if (raw == "int") {
    return(asJSON(as.integer(x), ...))
  } else if (raw == "js") {
    paste0('(new Uint8Array(', asJSON(as.integer(x), collapse = TRUE), '))')
  } else {
    # no as scalar here!
    return(asJSON(base64_enc(x), ...))
  }
})
