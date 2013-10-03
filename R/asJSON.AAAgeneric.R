setGeneric("asJSON",
	function(x, pretty=FALSE, ...){  
		ans <- standardGeneric("asJSON");
		if(isTRUE(pretty)){
			ans <-jsonPretty(ans);
		}
		return(ans);
	}
);
