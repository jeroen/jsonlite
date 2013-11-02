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
#' These columns are then guaranteed to be in the output data frame, even in the case when none of records contained this field.
#' If this argument is not specified, each unique field appearing in any of the records will used.
#' Note that this can lead to very large data frames with lots of \code{NA} values when the data contains different fields for each record.
#' 
#' Finally, something that is common in the case of JSON datasets is that records have again lists nested in them.
#' The \code{flatten} argument can be used to control how to deal with these cases. When set to \code{TRUE},
#' they will be unlisted and turn into several columns. 
#' 
#' @param recordlist a list of named lists representing records (rows).
#' @param columns character vector with names of the fields to extract. Optional but recommended when available.
#' @param flatten automatically unlist nested lists within the records. 
#' @export
#' @examples \dontrun{
#' library(httr)
#' res <- GET("https://api.github.com/users/hadley/repos")
#' obj <- fromJSON(rawToChar(res$content))
#' mydf1 <- simplifyDataFrame(obj, flatten=FALSE)
#' mydf2 <- simplifyDataFrame(obj, flatten=TRUE)
#' }
simplifyDataFrame <- function(recordlist, columns, flatten=TRUE) {
  
  #no records at all
	if(!length(recordlist)){
    if(!missing(columns)){
		  return(as.data.frame(matrix(ncol=length(columns), nrow=0, dimnames=list(NULL,columns))));
    } else {
      return(data.frame());
    }
	}	
  
	#only empty records and unknown columns
	if(!any(unlist(vapply(recordlist, length, integer(1)))) && missing(columns)){
    return(data.frame(matrix(nrow=length(recordlist), ncol=0)));
	}	
	
  #flatten list if set
  #must be a more efficient way to do this.
  #also 'null' values get lost (although they might come back later)
	if(isTRUE(flatten)){
	  recordlist <- lapply(recordlist, function(mylist){
		  lapply(rapply(mylist, base::enquote, how="unlist"), eval)
		});
	}
  
  #find columns if not specified
	if(missing(columns)){
	  columns <- unique(unlist(lapply(recordlist, names)))
	}
  
  #make new recordlist with requested only requested values
  recordlist <- lapply(recordlist, function(x) {
    #a new record with each requested column
    y <- structure(as.list(x)[columns], names=columns);

    #replace NULL with NA values in each record
    #lapply(y, function(z) {
    #  if(is.null(z)) NA else z;
    #})
  });
  
  #create a list of lists
  columnlist <- lapply(columns, function(x) lapply(recordlist, "[[", x))
  names(columnlist) <- columns;  
  
  #simplify into vectors where possible
  columnlist <- lapply(columnlist, function(x){
    if(is.scalarlist(x)){
      return(null2na(x))
    } else {
      return(x);
    }
  });
  
  #check that all elements have equal length
  columnlengths <- unlist(vapply(columnlist, length, integer(1)));
  if(length(unique(columnlengths)) > 1){
    stop("Elements not of equal length:", columnlengths);
  }
  
  #make into data frame
  n <- columnlengths[1];
  return(structure(columnlist, class="data.frame", row.names=1:n));
}
