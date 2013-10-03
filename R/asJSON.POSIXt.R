setMethod("asJSON", "POSIXt",
	function(x, POSIXt = c("string", "ISO8601", "epoch", "mongo"), UTC=FALSE, ...) {
		
		#Validate
		POSIXt <- match.arg(POSIXt);

		#Encode based on a schema
		if(POSIXt == "mongo"){
			if(is(x, "POSIXlt")){
				x <- as.POSIXct(x);
			}			
			y <-lapply(as.list(x), function(item){
				if(is.na(item)) return(item)
				as.scalar(list("$date" = as.scalar(floor((unclass(item)*1000)))));			
			});
			return(asJSON(y, digits=0, ...))
		} else if(POSIXt == "ISO8601"){
			return(asJSON(as.iso(x, UTC=UTC), ...));
		} else if(POSIXt == "string"){
			return(asJSON(as.character(x), ...));	
		} else if(POSIXt == "epoch"){
			return(asJSON(floor(unclass(x)*1000), ...));
		} else {
			stop("Invalid value for argument POSIXt:", POSIXt)
		}
	}
);
