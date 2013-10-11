#' Stringify R objects to JSON and vice versa.
#' 
#' These functions are used to convert R objects into JSON and back. 
#' The \code{toJSON} and \code{fromJSON} functions use a class schema with a somewhat untuitive encoding. 
#' This is convenient for clients but can only be used for basic R objects and ignores a lot of the object 
#' metadata. The \code{serializeJSON} and \code{unserializeJSON} functions on the other hand use type based
#' encoding which includes all metadata and will work for almost any object, but output can be very verbose.
#'
#' The \code{toJSON} and \code{fromJSON} are drop-in replacements for the identically named functions
#' in the RJSONIO package. The \code{toJSON} function stringifies an R object into JSON, and \code{fromJSON}
#' parses a JSON string into an R object. These implementations use an alternative, somewhat more consistent
#' mapping between R objects and JSON strings.
#' 
#' The \code{serializeJSON} and \code{unserializeJSON} functions also convert R objects to JSON and back, but
#' use a much more verbose encoding schema which includes all metadata from the object, such that an object 
#' can be almost perfectly restored from its JSON representation. 
#' 
#' @export fromJSON
#' @export toJSON
#' @useDynLib JSONlite
#' @name JSONlite
#' @aliases fromJSON
#' @param x the object to be encoded
#' @param pretty adds indentation whitespace to JSON output 
#' @param txt a string in json format 
#' @param simplify simplify arrays to vectors where possible 
#' @param safe don't evaluate language objects during unseriazing
#' @param ... arguments passed on to class specific methods
#' @note All encoded objects should pass the validation at www.jsonlint.org
#' @references
#' \url{http://www.jsonlint.org}
#' @author Jeroen Ooms \email{jeroen.ooms@@stat.ucla.edu}
#' @rdname JSONlite
#' @examples #stringify some data
#' jsoncars <- toJSON(mtcars, pretty=TRUE)
#' cat(jsoncars)
#' 
#' #parse it back
#' fromJSON(jsoncars)
#' 
#' #serialize i
#' jsoncars <- serializeJSON(mtcars)
#' mtcars2 <- unserializeJSON(jsoncars)
#' identical(mtcars, mtcars2)
#' 
#' # note that because of rounding, randomness and environments, 'identical' 
#' # is actually too strict.
#' set.seed('123')
#' myobject <- list(
#'   mynull = NULL,
#'   mycomplex = lapply(eigen(matrix(-rnorm(9),3)), round, 3),
#'   mymatrix = round(matrix(rnorm(9), 3),3),
#'   myint = as.integer(c(1,2,3)),
#'   mydf = cars,
#'   mylist = list(foo="bar", 123, NA, NULL, list("test")),
#'   mylogical = c(TRUE,FALSE,NA),
#'   mychar = c("foo", NA, "bar"),
#'   somemissings = c(1,2,NA,NaN,5, Inf, 7 -Inf, 9, NA),
#'   myrawvec = charToRaw("This is a test")
#' );
#' identical(unserializeJSON(serializeJSON(myobject)), myobject);
fromJSON <- function(txt, simplify = NA){

  #just hardcoding this for now
  encoding=NA;
  
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

#' @rdname JSONlite
#' @export
toJSON <- function(x, pretty=FALSE, ...){  
  asJSON(x, pretty=pretty, ...);
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



