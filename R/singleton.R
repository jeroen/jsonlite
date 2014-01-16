#' Mark a vector or data frame as singleton
#'
#' This function marks an atomic vector or data frame as a 
#' \href{http://en.wikipedia.org/wiki/Singleton_(mathematics)}{singleton}, i.e. 
#' a set with exactly 1 element. Thereby, the value will not turn into an
#' \code{array} when encoded into \code{JSON}. This can only be done for 
#' atomic vectors of length 1, or data frames with exactly 1 row. Because 
#' this function alters how R objects are encoded, it should be used
#' very sparsely, if at all.
#' 
#' It is usually recommended to avoid this function and stick with the default 
#' encoding schema for the various R classes. The only use case for this function
#' is if you are bound to some specific predifined \code{JSON} structure (e.g. to
#' submit to an API), which has no natural R representation. Note that the default
#' encoding for data frames naturally results in a collection of key-value pairs, 
#' without using \code{singleton}. If you are frequently using \code{singleton}, 
#' you're probably doing it wrong.
#'   
#' @param x atomic vector of length 1, or data frame with 1 row.
#' @return Returns a singleton version of \code{x}.
#' @export
#' @references \url{http://en.wikipedia.org/wiki/Singleton_(mathematics)}
#' @examples cat(toJSON(list(foo=123)))
#' cat(toJSON(list(foo=singleton(123))))
#' 
#' x <- iris[1,]
#' cat(toJSON(list(rec=x)))
#' cat(toJSON(list(rec=singleton(x))))
singleton <- function(x){
  if(is.data.frame(x)){
    if(nrow(x) == 1){
      return(as.scalar(x))
    } else {
      stop("Tried to encode dataframe with ", nrow(x), " rows as singleton.")
    }
  }
  if(!is.vector(x) || !is.atomic(x) || length(dim(x)) > 1){
    stop("Only atomic vectors of length 1 or data frames with 1 row can be a singleton.")
  }
  if(identical(length(x), 1L)){
    return(as.scalar(x))
  } else {
    stop("Tried to encode a vector of length ", length(x), " as singleton.")
  }
}
