setMethod("asJSON", "data.frame",
  function(x, drop.na=TRUE, container=TRUE, dataframe=c("rows", "columns"), raw, ...) {
    #Note: just as in asJSON.list we take the container argument to prevent it form being passed down through ...
    #This is needed in the rare case that a dataframe contains new dataframes, and hence as.scalar is inappropriate
    #
    #check how we want to encode
    dataframe <- match.arg(dataframe);
    
    #coerse pairlist if needed
    if(is.pairlist(x)){
      x <- as.vector(x, mode="list");
    }
    
    if(dataframe == "columns"){
      return(asJSON(as.list(x), drop.na=drop.na, container=container, dataframe="columns", raw="hex", ...));
    }

    #if we have no rows, just return: []
    if(nrow(x) == 0){
      return(asJSON(list(), ...));
    }
    
    #Convert POSIXlt to POSIXct before we start messing with lists
    posvars = which(as.logical(vapply(x, is, integer(1), "POSIXlt")));
    for(i in posvars){
      x[[i]] <- as.POSIXct(x[[i]]);
    }
    
    #Check for row names
    if(!isTRUE(all(grepl("[0-9]+", row.names(x))))){
      x <- cbind(data.frame("$row" = row.names(x), check.names=FALSE), x);
    }
    
    #Get a list of rows.
    #This is the computationally expensive part.
    out <- list();
    for(i in 1:nrow(x)){
      out[[i]] <- x[i, ,drop=FALSE];
    }

    #don't explicitly encode missing values in records (just drop them)
    if(isTRUE(drop.na)){
      out <- lapply(out, function(record) {
        na_values <- vapply(record, function(z){isTRUE(is.na(z))}, logical(1));
        return(as.list(record[1, !na_values, drop=FALSE]));
      });
    }

    #add scalar too all elements to prevent [] containers.
    out <- lapply(out, lapply, as.scalar);
    
    #we assume a dataframe with one row
    if(!isTRUE(container)){
      if(length(out) == 1){
        out <- out[[1]];
      } else {
        warning("As.scalar used for dataframe with more than one row.")
      }
    }    
    
    #pass on to asJSON.list
    return(asJSON(out, raw="hex", ...));
  }
);