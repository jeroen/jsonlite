setMethod("asJSON", "logical",
	function(x, container = TRUE, ...) {
    
	  #empty vector
	  if(!length(x)) return("[]");    
		
		#json true/false
		tmp = ifelse(x, "true", "false");

		#logical values can have NA (but not Inf/NaN). We encode NA as null
		if(any(missings <- is.na(x))){
			tmp[missings] <- "null";
		}		
		
		#wrap in container
		if(container) {
			return(paste("[", paste(tmp, collapse = ", "), "]"));
		} else{
			return(tmp);
		}
	}
);
