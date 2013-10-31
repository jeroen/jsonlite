simplify <- function(x){
  if(is.list(x)){
    if(!length(x)){
      # In case of fromJSON("[]") returning a list is most neutral.
      # Because the user can do as.vector(list()) and as.data.frame(list()) which both results in the correct object.
      return(list())
    }
    # list can be a dataframe recordlist
    if(is.recordlist(x)){
      mydf <- records2df(x);
      if("$row" %in% names(mydf)){
        row.names(mydf) <- mydf[["$row"]];
        mydf["$row"] <- NULL;
      }
      return(mydf);
    }
    
    # or a scalar list (atomic vector)
    if(is.null(names(x)) && is.scalarlist(x)){
        return(null2na(x)); 
    }
    
    return(lapply(x, simplify))
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
