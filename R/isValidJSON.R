#' @export isValidJSON
isValidJSON <- function(txt){
	stopifnot(is.character(txt))
	txt <- paste(txt, collapse="\n")
	.Call("R_isValidJSON", as.character(txt))
}