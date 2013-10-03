builddf <- function(records, list){
	colnames <- list$attributes$names$value;
	mydf <- records2df(records, columns=colnames, flatten=FALSE);
	
	for(i in 1:length(colnames)){
		list$value[[i]]$value <- mydf[[i]];
	}
	return(list);
}
