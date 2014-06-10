setMethod("asJSON", "data.frame", function(x, na = c("NA", "null", "string"), 
  collapse = TRUE, dataframe = c("rows", "columns"), complex = "string", oldna=NULL, ...) {

  # Validate some args
  dataframe <- match.arg(dataframe)
  
  # Coerse pairlist if needed
  if (is.pairlist(x)) {
    x <- as.vector(x, mode = "list")
  }
  
  # Colum based is same as list based
  if (dataframe == "columns") {
    return(asJSON(as.list(x), na = na, collapse = collapse, dataframe = dataframe, complex=complex, ...))
  }

  # Determine "oldna". This is needed when the data frame contains a list column
  if(missing(na) || !length(na) || identical(na, "NA")){
    oldna <- NULL
  } else {
    oldna <- na;
  }
  
  # Set default for row based, don't do it earlier because it will affect 'oldna' or dataframe="columns"
  na <- match.arg(na)
  
  # no records
  if (!nrow(x)) {
    return(asJSON(list(), collapse=collapse))
  }
  
  # Convert POSIXlt to POSIXct before we start messing with lists
  posvars <- which(as.logical(vapply(x, is, integer(1), "POSIXlt")))
  for (i in posvars) {
    x[[i]] <- as.POSIXct(x[[i]])
  }
  
  # Convert raw vectors
  rawvars <- which(as.logical(vapply(x, is.raw, integer(1))))
  for (i in rawvars) {
    x[[i]] <- as.character.hexmode(x[[i]])
  }  
  
  # Turn complex vectors into data frames
  if(complex == "list"){
    complxvars <- which(as.logical(vapply(x, is.complex, integer(1))))
    for (i in complxvars) {
      x[[i]] <- data.frame(real=Re(x[[i]]), imaginary=Im(x[[i]]))
    }
  }
  
  # Check for row names
  if (!isTRUE(all(grepl("[0-9]+", row.names(x))))) {
    x <- cbind(data.frame(`$row` = row.names(x), check.names = FALSE), x)
  }
  
  #create a matrix of json elements
  dfnames <- deparse_vector(cleannames(names(x)))
  out <- vapply(x, asJSON, character(nrow(x)), collapse=FALSE, complex = complex, na = na, oldna = oldna, ...)
  
  # This would be another way of doing the missing values
  # This does not require the individual classes to support na="NA"
  #if(identical(na, "NA")){
  #  namatrix <- vapply(x, is.na, logical(nrow(x)))
  #  out[namatrix] <- NA;
  #}
  
  #this is a workaround for vapply simplifying into a vector for n=1 (not for n=0 surprisingly)
  if(!is.matrix(out)){
    out <- t(out)
  }
  
  #turn the matrix into json records
  if(na == "NA") {
    tmp <- apply(out, 1, function(z){
      missings <- is.na(z);
      if(any(missings)){
        paste0("{", paste(dfnames[!missings], z[!missings], sep = ":", collapse = ","), "}")
      } else {
        paste0("{", paste(dfnames, z, sep = ":", collapse = ","), "}")
      }
    });
  } else {
    #tiny speed up because we don't have to check for NA 
    tmp <- apply(out, 1, function(z){
      paste0("{", paste(dfnames, z, sep = ":", collapse = ","), "}")
    });    
  }
  
  #collapse
  if(isTRUE(collapse)){
    collapse(tmp)
  } else {
    tmp
  }
}) 
