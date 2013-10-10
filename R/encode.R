#' Encode an R object to standardized JSON notation
#'
#' A standard json encoding has been defined to store S3 data objects
#' in a way that they will can be (almost) completely restored.
#' 
#' @export
#' @param obj the R object to be encoded
#' @param ... arguments for asJSON
#' @return A valid JSON string
#'
#' @note All encoded objects should pass the validation at www.jsonlint.org
#' @references
#' \url{http://www.jsonlint.org}
#' @author Jeroen Ooms \email{jeroen.ooms@@stat.ucla.edu}
#' @examples jsoncars <- encode(cars);
#' cat(jsoncars);
#' identical(decode(jsoncars), cars);
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
#' identical(decode(encode(myobject)), myobject);
#'
 

encode <- function(obj, ...){
	#just to verify that obj exists
	is(obj);
	#we pass arguments both to asJSON as well as packaging object.
	return(asJSON(packageObject(obj, ...), ...));
}
