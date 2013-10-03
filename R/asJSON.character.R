setMethod("asJSON", "character",
	function(x, container = TRUE, ...) {
		
		#0 vector is not handled properly by paste()
		if(length(x) == 0){
			return("[ ]")
		}
		
		#vectorized escaping
		tmp <- deparse_vector(x)
		tmp[is.na(x)] <- "null";
		tmp <- paste(tmp, collapse = ", ")
		
		#this is almost always true, except for class 'scalar'
		if(container) {
			tmp <- paste("[", tmp, "]");
		}
		
		#return
		return(tmp);
	}
);
