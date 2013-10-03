#' Convert a json string to an R object.
#' 
#' @param txt a string in json format 
#' @param simplify simplify arrays to vectors where possible
#' @param encoding specify character encoding (e.g. "UTF8")
#' @return An R object.
#' @export
fromJSON <- function(txt, simplify = NA, encoding=NA){
	
	#this is always a bad idea
	simplifyWithNames = FALSE;
	
	#readLines splits into a vector
	txt <- paste(txt, collapse="\n")
	
	#see RJSONIO for the logic behind these values
	#simply TRUE or FALSE will do as well.
	if(is.na(simplify)){
		StrictLogical = 2L
		StrictNumeric = 4L
		StrictCharacter = 8L
		Strict = StrictNumeric + StrictCharacter + StrictLogical
		simplify <- Strict
	}
	
	#in case if chineese, etc.
	if(is.na(encoding)){
		encoding <- Encoding(txt)	
	} 
	enc <- mapEncoding(encoding);
	
	#libjson call
	.Call("R_fromJSON", txt, as.integer(simplify), NULL, as.logical(simplifyWithNames), enc, NULL, stringFunType = c("GARBAGE" = 4L))  
}


#maps encoding name to integer
mapEncoding <- function(encoding){
	if(is.na(encoding)){
		return(0L);
	}
	
	codes <- c(
			"unknown" = 0L, 
			"native" = 0L, 
			"utf8" = 1L,  
			"utf-8" = 1L, 
			"latin1" = 2L, 
			"bytes" = 3L, 
			"symbol" = 5L, 
			"any" = 99L
	);
	
	enc = pmatch(tolower(encoding), names(codes))
	if(is.na(enc)) {
		stop("unrecognized encoding:", encoding);
	}
	return(	codes[enc] );
}
