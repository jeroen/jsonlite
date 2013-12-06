#' Add class 'scalar' to an object
#'
#' Function simply adds class 'scalar' to the object and returns it.
#' Objects of class 'scalar' of length 1 will be encoded as a json primitive instead of an array.
#' 
#' @param obj the R object to classified as scalar.
#' @return The same R object
#' @author Jeroen Ooms \email{jeroen.ooms@@stat.ucla.edu}
#' @examples toJSON(list(foo=123));
#' toJSON(list(foo=as.scalar(123)));
as.scalar <- function(obj) {
  # Lists can never be a scalar (this can arise if a dataframe contains a column with lists)
  if (is.data.frame(obj)) {
    if (nrow(obj) > 1) {
      warning("as.scalar was applied to dataframe with more than 1 row.")
      return(obj)
    }
  } else {
    if (length(obj) > 1) {
      warning("as.scalar was applied to an object of length > 1.")
      return(obj)
    }
  }
  
  class(obj) <- c("scalar", class(obj))
  return(obj)
} 
