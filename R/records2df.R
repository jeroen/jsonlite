#' Convert a list of records into a dataframe
#' 
#' A helper function to convert a list with records into a dataframe.
#' 
#' @param recordlist a list of lists representing records (rows)
#' @param columns optional. Character vector of the names of the fields to extract.
#' @param flatten if records should be unlisted.
#' @return dataframe
#' @examples myjson <- toJSON(cars)
#' myrecords <- fromJSON(myjson)
#' records2df(myrecords);
records2df <- function(recordlist, columns, flatten=TRUE) {
  #internal helper function
  flatlist <- function(mylist){
    lapply(rapply(mylist, base::enquote, how="unlist"), eval)
  }
  
  #only empty records
  if(!any(sapply(recordlist, length))){
    return(data.frame(matrix(nrow=length(recordlist), ncol=0)));
  }
  
  #convert NULL values to NA
  recordlist <- lapply(recordlist, null2na, unlist=FALSE);
  
	if(length(recordlist)==0 && !missing(columns)){
		return(as.data.frame(matrix(ncol=length(columns), nrow=0, dimnames=list(NULL,columns))))
	}	
	
	if(isTRUE(flatten)){
		un <- lapply(recordlist, flatlist);
	} else {
		un <- recordlist;
	}
	if(!missing(columns)){
		ns <- columns;
	} else {
		ns <- unique(unlist(lapply(un, names)))
	}
	
	un <- lapply(un, function(x) {
		y <- as.list(x)[ns]
		names(y) <- ns
		lapply(y, function(z) if(is.null(z)) NA else z)})
	s <- lapply(ns, function(x) sapply(un, "[[", x))
	names(s) <- ns;
	
	#in case anything contains lists
	islist <- sapply(s, is.list);
	if(sum(!islist) > 0){
		outdf <- data.frame(s[!islist], stringsAsFactors=FALSE, check.names=FALSE);
	} else {
		outdf <- as.data.frame(matrix(nrow=length(s[islist][[1]]), ncol=0))
	}
	
	#append lists
	for(i in which(islist)){
		outdf[names(s[i])] <- s[i];
	}
	return(outdf);
}
