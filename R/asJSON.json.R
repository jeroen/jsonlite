# If an object has already been encoded by toJSON(), do not encode it again
setMethod("asJSON", "json", function(x, double_encode = TRUE, ...) {
  if(isTRUE(double_encode)){
    asJSON(as.character(x), double_encode = TRUE, ...)
  } else {
    x
  }
})
