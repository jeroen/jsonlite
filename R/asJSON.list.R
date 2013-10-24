setMethod("asJSON", "list",
	function(x, container=TRUE, ...) {
		
		#We are explicitly taking the container argument to prevent it from being passed down through ... (elipse)
		#As scalar should never be applied to an entire list (unless it is POSIXlt or so)
    
	  #coerse pairlist if needed
	  if(is.pairlist(x)){
	    x <- as.vector(x, mode="list");
	  }    
			
		# Emtpy list:
		if(length(x) == 0) {
			return(if(is.null(names(x))) "[]" else "{}");
		}
		
		# this condition appears when a dataframe contains a column with lists
		# we need to do this, because the [ operator always returns a list of length 1
		if(length(x) == 1 && is.null(names(x)) && container == FALSE){
			return(asJSON(x[[1]], ...));
		}
		
		#note we are NOT passing on the container argument.
		els = sapply(x, asJSON, ...)
		
		if(all(sapply(els, is.name)))
			names(els) = NULL
		
		if(length(names(x))) {
			return(
				paste("{", paste(deparse_vector(names(x)), els, sep = " : ", collapse = ", "), "}")
			);
		} else {
			return(
				paste("[", paste(els, collapse = ","), "]")
			);
		}
	}
);

