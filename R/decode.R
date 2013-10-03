#' Decode a JSON string to an R object
#'
#' A standard json encoding has been defined to store S3 data objects
#' in a way that they will can be (almost) completely restored.
#' 
#' @export
#' @param jsonstring A character string containing the JSON data.
#' @param safe Safe decoding. When FALSE, code will be evaluated during decoding.
#' @return An R object
#'
#' @note All encoded objects should pass the validation at www.jsonlint.org
#' @references
#' \url{http://www.jsonlint.org}
#' @author Jeroen Ooms \email{jeroen.ooms@@stat.ucla.edu}


decode <- function(jsonstring, safe=TRUE){
	depackageObject(fromJSON(jsonstring), safe=safe);
}
