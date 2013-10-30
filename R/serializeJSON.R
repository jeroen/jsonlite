#' @export
#' @return JSON string
#' @rdname JSONlite
serializeJSON <- function(x, digits = 8, pretty = FALSE){
	#just to verify that obj exists
	is(x);
	#we pass arguments both to asJSON as well as packaging object.
	return(asJSON(pack(x), NA_as_string = TRUE, digits=digits, pretty=pretty));
}

#' @export
#' @return Unserialized R object
#' @rdname JSONlite
unserializeJSON <- function(txt){
  unpack(fromJSON(txt, smart=FALSE));
}
