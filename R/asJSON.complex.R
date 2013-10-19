setMethod("asJSON", "complex",
	function(x, digits=5, container=TRUE, complex=c("string", "list"), NA_as_string, ...) {
		#validate
		complex <- match.arg(complex);
		
		if(complex == "string"){
			mystring <- prettyNum(x=x, digits=digits);
			mystring[is.na(x)] <- NA;
			if(!container){
				mystring <- as.scalar(mystring);
			}
			return(asJSON(mystring, NA_as_string=NA_as_string, ...));
		} else {
			mylist <- list(real=Re(x), imaginary=Im(x));
			
			#this is a bit of a hack
			#if container is false, this is length 1 vector
			#so we have to actually apply this so the real and imaginary elements of the list
			if(!container){
				mylist <- lapply(mylist, as.scalar);
			}
			
			#return
			return(asJSON(mylist, NA_as_string=FALSE, ...));
		}
	}
);
