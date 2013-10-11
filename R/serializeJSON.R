#' @export
#' @rdname JSONlite
serializeJSON <- function(x, ...){
	#just to verify that obj exists
	is(x);
	#we pass arguments both to asJSON as well as packaging object.
	return(asJSON(packageObject(x, ...), ...));
}

#' @export
#' @rdname JSONlite
unserializeJSON <- function(txt, safe=TRUE){
  depackageObject(fromJSON(txt), safe=safe);
}

