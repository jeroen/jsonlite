setOldClass("AsIs")
setMethod("asJSON", "AsIs", function(x, ...) {
  #remove class "AsIs"
  class(x) <- class(x)[-1]
  
  #This also checks if the object is of length one
  x <- as.scalar(x)
  
  #encode without collapsing
  asJSON(x, ...)
})
