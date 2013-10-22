simplify <- function(x){
  if(is.list(x)){
    # list can be a dataframe recordlist
    if(is.recordlist(x)){
      return(records2df(x));
    }
    
    # or a scalar list (atomic vector)
    if(is.null(names(x)) && is.scalarlist(x)){
        return(null2na(x)); 
    }
    
    # or just a recursive list
    for(i in seq_along(x)){
      x[[i]] <- Recall(x[[i]]);
    }
    return(x);
  } else {
    return(x);
  }
}

is.scalarlist <- function(x){
  isTRUE(is.list(x) && all(sapply(x, function(y){mode(y) %in% c("numeric", "logical", "character", "complex", "NULL") && (length(y) <= 1)})));
}

is.namedlist <- function(x){
  isTRUE(is.list(x) && !is.null(names(x)));
}

is.recordlist <- function(x){
  isTRUE (
    is.list(x) &&
    length(x) && 
    all(sapply(x, is.namedlist)) &&
    all(sapply(x, is.scalarlist))
  );
}

null2na <- function(x){
  #parse explicitly quoted missing values
  #If they are actually character strings they will automatically be casted back by unlist.
  missings <- x %in% c("NA", "Inf", "-Inf", "NaN");
  x[missings] <- lapply(x[missings], evaltext);
  
  #parse 'null' values
  x[unlist(sapply(x, is.null))] <- NA;
  return(unlist(x));
}
