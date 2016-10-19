as.scalar <- function(obj) {
  # Lists can never be a scalar (this can arise if a dataframe contains a column
  # with lists)
  if(length(dim(obj)) > 1){
    if(!identical(nrow(obj), 1L)){
      warning("Tried to use as.scalar on an array or dataframe with ", nrow(obj), " rows.", call.=FALSE)
      return(obj)
    }
  } else if(!identical(length(obj), 1L)) {
    warning("Tried to use as.scalar on an object of length ", length(obj), call.=FALSE)
    return(obj)
  } else if(is.namedlist(obj)){
    warning("Tried to use as.scalar on a named list.", call.=FALSE)
    return(obj)
  }

  class(obj) <- c("scalar", class(obj))
  return(obj)
}

check_scalar <- function(obj) {
  if(length(dim(obj)) > 1){
    if(!identical(nrow(obj), 1L)){
      stop("Scalar cannot be an array or dataframe with ", nrow(obj), " rows.", call.=FALSE)
    }
  } else if(!identical(length(obj), 1L)) {
    stop("Scalar cannot be an object of length ", length(obj), call.=FALSE)
  } else if(is.namedlist(obj)){
    stop("Scalar cannot be a named list.", call.=FALSE)
  }

  obj
}
