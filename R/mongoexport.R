#' Export to MongoDB
#' 
#' Exports a dataframe to a format that can be imported with 'mongoimport'.
#' 
#' By default mongoimport expects a datafile in which every line is a record 
#' in the collection. Hence the complete output is not valid json itself.
#' Alternatively, if jsonArray=TRUE the output will be wrapped a JSON array. 
#' When using the latter, we need to pass --jsonArray to mongoimport.
#' 
#' @param x a dataframe
#' @param jsonArray if output should be an array. See details. 
#' @param ... args passed on to asJSON
#' @export
toMongo <- function(x, jsonArray=FALSE, ...){
	if(!is.data.frame(x)){
		stop("toMongo only exports dataframes.");
	}
	
	#by default mongoimport expects an entry per line
	if(isTRUE(jsonArray)){
		output <- asJSON(x, POSIXt="mongo", raw="mongo", ...)
	} else {
		output <- rep(NA, nrow(x));	
		for(i in 1:nrow(x)){
			output[i] <- asJSON(as.scalar(x[i, ,drop=FALSE]), POSIXt="mongo", raw="mongo", pretty=FALSE, ...);
		}
	}
	return(paste(output, collapse="\n"));	
}
