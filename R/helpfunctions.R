#S4 to list object. Not quite sure if this really works in general.
#You probably shouldn't use S4 with JSON anyway.

S4tolist <- function(x){
	structure(
		lapply(slotNames(x), slot, object=x),
		.Names = slotNames(x)
	)
}

#ENCODING TOOLS

# opposite of unname:
# force list into named list
# to get key/value json encodings
givename <- function(obj){
	return(structure(obj, names=as.character(names(obj))))
}

#vectorized deparse
deparse_vector <- function(x){
	stopifnot(is.character(x))
	unlist(lapply(as.list(x), deparse))
}

#trim whitespace
trim <-	function (x){ 
	gsub("(^[[:space:]]+|[[:space:]]+$)", "", x);
}

#put double quotes around a string
wrapinquotes <- function(x){
	paste('"', x, '"', sep = "");
}

#DECODING TOOLS
evaltext <- function(text){
	return(eval(parse(text=text)))
}

null2na <- function(x){
	#parse explicitly quoted missing values
	missings <- x %in% c("NA", "Inf", "-Inf", "NaN");
	x[missings] <- lapply(x[missings], evaltext);
	
	#parse 'null' values
	x[unlist(sapply(x, is.null))] <- NA;
	return(unlist(x));
}