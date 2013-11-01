#' Convert a list of records into a dataframe
#' 
#' A helper function to convert a list with records, which are common in JSON datasets, into a dataframe. 
#' 
#' Data frames in R are colum based, but most data sets in JSON are provided in a row-based format; 
#' i.e. an array of key-value pairs. For example \url{https://api.github.com/users/hadley/repos}.
#' This function converts a collection of records into a data frame. The input is a list of lists, as it would 
#' be returned by \code{fromJSON} without any simplification.
#' 
#' The \code{column} argument is a vector specifying which fields (list elements) need to be extracted and turned data frame columns. 
#' If this argument is not specified, each unique field appearing in any of the records will used.
#' Note that this can lead to very large data frames with lots of \code{NA} values when the data contains different fields for each record.
#' 
#' Finally, something that is common in the case of JSON datasets is that records have again lists nested in them.
#' The \code{flatten} argument can be used to control how to deal with these cases. When set to \code{TRUE},
#' they will be unlisted and turn into several columns. 
#' 
#' @param recordlist a list of lists representing records (rows).
#' @param columns optional. Character vector of the names of the fields to extract. 
#' @export
#' @examples \dontrun{
#' library(httr)
#' res <- GET("https://api.github.com/users/hadley/repos")
#' obj <- fromJSON(rawToChar(res$content), smart=FALSE)
#' mydf1 <- records2df(obj, flatten=FALSE)
#' mydf2 <- records2df(obj, flatten=TRUE)
#' }
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
