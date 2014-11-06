setOldClass("int64")
setMethod("asJSON", "int64", function(x, digits, ...) {
  asJSON(as.double(as.character(x)), digits = 0, ...)
})

setOldClass("integer64")
setMethod("asJSON", "integer64", function(x, digits, ...) {
  asJSON(as.double(x), digits = 0, ...)
})
