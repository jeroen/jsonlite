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
  
  #only empty records
  if(!any(sapply(recordlist, length))){
    return(data.frame(matrix(nrow=length(recordlist), ncol=0)));
  }

  #no records at all
	if(length(recordlist)==0 && !missing(columns)){
		return(as.data.frame(matrix(ncol=length(columns), nrow=0, dimnames=list(NULL,columns))))
	}	
	
  #flatten list if set
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
    lapply(y, function(z) {
      if(is.null(z)) NA else z;
    })
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
