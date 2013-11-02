#' Stringify R objects to JSON and vice versa
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
#' can be almost perfectly restored from its JSON representation. The serializeJSON function bases its encoding
#' on the storage mode of an object, and almost every storage mode is supported (except for environments). 
#' However note that JSON is a (non-binary) ascii format and therefore numeric precision is limited by how 
#' many digits you decide to print.
#' 
#' @export fromJSON
#' @export toJSON
#' @useDynLib JSONlite
#' @name JSONlite
#' @aliases fromJSON
#' @param x the object to be encoded
#' @param dataframe how to encode data.frame objects: must be one of "row" or "column"
#' @param Date how to encode Date objects: must be one of "ISO8601" or "epoch"
#' @param POSIXt how to encode POSIXt (datetime) objects: must be one of "string", "ISO8601", "epoch" or "mongo"
#' @param factor how to encode factor objects: must be one of "string" or "integer"
#' @param complex how to encode complex numbers: must be one of "string" or "list"
#' @param raw how to encode raw objects: must be one of "base64" or "mongo"
#' @param digits max number of digits (after the dot) to print for numeric values
#' @param NA_as_string print numeric NA values as strings. If set to FALSE, numeric NA values turn into null
#' @param drop.na Don't include NA values in dataframes. Only used when dataframe="rows".
#' @param pretty adds indentation whitespace to JSON output 
#' @param txt a string in json format 
#' @param smart try to convert JSON into vectors and data frames where possible. If set to FALSE, everything is a list.
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
fromJSON <- function(txt, simplifyVector = TRUE, simplifyDataFrame = TRUE, simplifyMatrix = TRUE){
  
  #parse JSON
  obj <- parseJSON(txt);
  
  #post processing
  if(any(isTRUE(simplifyVector), isTRUE(simplifyDataFrame), isTRUE(simplifyMatrix))){
    return(simplify(obj, simplifyVector=simplifyVector, simplifyDataFrame=simplifyDataFrame, simplifyMatrix=simplifyMatrix));
  } else{
    return(obj);
  }
}

#' @rdname JSONlite
#' @export
toJSON <- function(x,
  dataframe=c("rows", "columns"),
  Date = c("ISO8601", "epoch"), 
  POSIXt = c("string", "ISO8601", "epoch", "mongo"),
  factor = c("string", "integer"), 
  complex = c("string", "list"),
  raw = c("base64", "mongo"),
  digits = 2, 
  NA_as_string = TRUE,
  drop.na=TRUE,                 
  pretty = FALSE,
  ...
){  
  
  #validate args
  dataframe <- match.arg(dataframe);
  Date <- match.arg(Date);
  POSIXt <- match.arg(POSIXt);
  factor <- match.arg(factor);
  complex <- match.arg(complex);  
  raw <- match.arg(raw);
  
  #force
  x <- force(x);
    
  #dispatch
  asJSON(x, dataframe=dataframe, Date=Date, POSIXt=POSIXt, factor=factor, complex=complex, raw=raw, 
    digits=digits, NA_as_string=NA_as_string, drop.na=drop.na, pretty=pretty, ...);
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
