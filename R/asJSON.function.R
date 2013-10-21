setMethod("asJSON", "function",
  function(x, container = TRUE, fun=c("source", "list"), ...) {
    #validate
    fun <- match.arg(fun);
    
    if(fun == "source"){
      return(asJSON(deparse(x), ...));
    } else {
      return(asJSON(as.list(x), ...));
    }
  }
);
