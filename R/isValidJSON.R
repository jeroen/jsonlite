#' Validate JSON
#' 
#' Test if a string is a valid JSON string. Characters vectors will be collapsed into a single string.
#' 
#' @param txt JSON string
#' @export isValidJSON
isValidJSON <- function(txt){
	stopifnot(is.character(txt))
	txt <- paste(txt, collapse="\n")
	.Call("R_isValidJSON", as.character(txt))
}