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
  # Lists can never be a scalar (this can arise if a dataframe contains a column
  # with lists)
  if(length(dim(obj)) > 1){
    if(!identical(nrow(obj), 1L)){
      warning("Tried to use as.scalar on an array or dataframe with ", nrow(obj), " rows.")
      return(obj)
    }
  } else if(!identical(length(obj), 1L)) {
    warning("Tried to use as.scalar on an object of length ", length(obj))
    return(obj)
  } else if(is.namedlist(obj)){
    warning("Tried to use as.scalar on a named list.")
    return(obj)
  }
  
  class(obj) <- c("scalar", class(obj))
  return(obj)
} 
