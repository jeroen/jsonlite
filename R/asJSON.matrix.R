#NOTE: opencpu.encode is never upposed to use this function, because it unclasses every object first.
# it is included for completeness.

setMethod("asJSON", "matrix",
	function(x, container = TRUE, ...) {
		
		#row based json
		tmp = paste(apply(x, 1, asJSON, ...), collapse = ", ")
		
		#wrap in container
		if(container){
			tmp <- paste("[", tmp, "]");
		}
		
		#return
		return(tmp);		
	}
);
