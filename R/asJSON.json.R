# If an object has already been encoded by toJSON(), do not encode it again
setMethod("asJSON", "json", function(x, ...) {
  x
})
