setMethod("asJSON", "factor",
	function(x, factor=c("string", "integer"), ...) {
		
		#validate
		factor <- match.arg(factor);
		
		if(factor == "integer"){
			#encode factor as enum			
			return(asJSON(unclass(x), ...));
		} else {
			#encode as strings
			return(asJSON(as.character(x), ...));
		}
	}
);
