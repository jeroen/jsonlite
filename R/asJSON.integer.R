setOldClass("integer")
setMethod("asJSON", "integer", function(x, digits, ...) {
  asJSON(as.double(x), digits = 0, ...)
}) 
