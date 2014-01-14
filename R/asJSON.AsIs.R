setMethod("asJSON", "AsIs", function(x, ...) {
  #change AsIs into "scalar"
  class(x)[1] <- "scalar";
  
  #encode without collapsing
  asJSON(x, ...)  
})
