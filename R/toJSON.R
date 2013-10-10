#' Stringify an R object to JSON.
#'
#' This is a modified version of the toJSON function in RJSONIO.
#'  
#' @export fromJSON
#' @export toJSON
#' @useDynLib JSONlite
#' @param x the object to be serialized
#' @param pretty does some post pretty printing. 
#' @param ... arguments passed on to class specific methods
#' @return A valid JSON string
#' @note All encoded objects should pass the validation at www.jsonlint.org
#' @references
#' \url{http://www.jsonlint.org}
#' @author Jeroen Ooms \email{jeroen.ooms@@stat.ucla.edu}
#' @examples jsoncars <- toJSON(mtcars, pretty=TRUE);
#' cat(jsoncars);
toJSON <- function(x, pretty=FALSE, ...){  
  asJSON(x, pretty=pretty, ...);
}

