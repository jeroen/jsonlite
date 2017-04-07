# Wrappers for common classes
setMethod("asJSON", "ts", function(x, ...) {
  asJSON(as.vector(x), ...)
})
