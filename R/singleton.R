#' Mark a vector or data frame as singleton
#'
#' This function marks a vector or data frame as a 'singleton'. Thereby, the
#' value will not turn into an \code{array} when encoded into \code{JSON}. This
#' can only be done for vectors of length 1, or data frames with exactly 1 row. 
#' Because this function alters how R objects are encoded, it should be used
#' very sparsely, if at all.
#' 
#' It is highly recommended to avoid this function and stick with the default 
#' encoding schema for the various R classes. Note that the default encoding 
#' for data frames naturally results in a collection of key-value pairs, without
#' using \code{singleton}. If you are frequently using \code{singleton}, you're 
#' probably doing it wrong. The only use case for this function is if you are
#' are tried to some specific \code{JSON} structure (e.g. to submit to an API),
#' which has no natural R representation. 
#'   
#' @param x a vector of length 1, or data frame with 1 row.
#' @return Returns a singleton version of \code{x}.
#' @export
#' @examples toJSON(list(foo=123))
#' toJSON(list(foo=singleton(123)))
#' 
#' x <- iris[1,]
#' toJSON(list(rec=x))
#' toJSON(list(rec=singleton(x)))
singleton <- function(x){
  if(is.data.frame(x)){
    if(nrow(x) == 1){
      return(as.scalar(x))
    } else {
      stop("Tried to encode dataframe with ", nrow(x), " rows as singleton.")
    }
  }
  if(length(dim(x)) > 1){
    stop("Only vectors of length 1 or data frames with 1 row can be a singleton.")
  }
  if(is.namedlist(x)){
    stop("Named lists can not be a singleton.")
  }
  if(identical(length(x), 1L)){
    return(as.scalar(x))
  } else {
    stop("Only vectors of length 1 or data frames with 1 row can be a singleton.")
  }
}
