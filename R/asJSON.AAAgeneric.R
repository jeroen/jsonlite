#This file is called AAA so that it will be run first.

#' Serialize an R object to JSON.
#'
#' This is a slightly modified version of the asJSON function in RJSONIO. This function is mostly for internal use. 
#' Please use opencpu.encode instead.
#'  
#' @export fromJSON
#' @export asJSON
#' @useDynLib encode
#'  
#' @aliases asJSON,ANY-method asJSON,AsIs-method asJSON,character-method asJSON,integer-method
#' asJSON,list-method asJSON,logical-method asJSON,matrix-method asJSON,NULL-method 
#' asJSON,Date-method asJSON,POSIXt-method asJSON,classRepresentation-method asJSON,complex-method
#' asJSON,data.frame-method asJSON,factor-method asJSON,int64-method asJSON,raw-method
#' asJSON,numeric-method asJSON,scalar-method
#' @param x the object to be serialized
#' @param pretty does some post pretty printing. 
#' @return A valid JSON string
#'
#' @note All encoded objects should pass the validation at www.jsonlint.org
#' @references
#' \url{http://www.jsonlint.org}
#' @author Jeroen Ooms \email{jeroen.ooms@@stat.ucla.edu}
#' @examples jsoncars <- asJSON(cars, pretty=TRUE);
#' cat(jsoncars);

setGeneric("asJSON",
	function(x, pretty=FALSE, ...){  
		ans <- standardGeneric("asJSON");
		if(isTRUE(pretty)){
			ans <-jsonPretty(ans);
		}
		return(ans);
	}
);
