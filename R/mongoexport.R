#' Export to mongo
#' 
#' Exports a dataframe to a format that can be imported with 'mongoimport'.
#' 
#' By default mongoimport expects a datafile in which every line is a record 
#' in the collection. Hence the complete output is not valid json itself.
#' Alternatively, if jsonArray=TRUE the output will be wrapped into a json 
#' array. Note that if this is the case, one has to pass --jsonArray to 
#' mongoimport as well.#' 
#' 
#' @param x a dataframe
#' @param jsonArray if output should be an array. See details. 
#' @param ... args passed on to asJSON
#' @return character vector. If jsonArray=TRUE the output will always have 
#' length 1.
#' @export
mongoexport <- function(x, jsonArray=FALSE, ...){
	if(!is.data.frame(x)){
		stop("mongoexport only exports dataframes.");
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
