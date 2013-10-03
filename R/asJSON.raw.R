setMethod("asJSON", "raw",
	function(x, raw=c("base64", "mongo"), ...) {
		
		#validate
		raw <- match.arg(raw);
		
		#encode based on schema
		if(raw == "mongo"){
			return(asJSON(list(
				"$binary" = as.scalar(base64_encode(x)),
				"$type" = as.scalar("\x05")
			)));	
		} else {
			return(asJSON(as.scalar(base64_encode(x)), ...));
		}
	}
);
