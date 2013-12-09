setMethod("asJSON", "data.frame", function(x, na = c("default", "null", "string", "NA"), 
  collapse = TRUE, dataframe = c("rows", "columns"), raw, complex="string", ...) {

  #validate some args
  dataframe <- match.arg(dataframe)
  na <- match.arg(na)
  
  # coerse pairlist if needed
  if (is.pairlist(x)) {
    x <- as.vector(x, mode = "list")
  }
  
  if (dataframe == "columns") {
    return(asJSON(as.list(x), na = na, collapse = collapse, dataframe = dataframe, 
      raw = "hex", complex=complex, ...))
  }
  
  # no records
  if (!nrow(x)) {
    return(asJSON(list(), collapse=collapse))
  }
  
  # Convert POSIXlt to POSIXct before we start messing with lists
  posvars <- which(as.logical(vapply(x, is, integer(1), "POSIXlt")))
  for (i in posvars) {
    x[[i]] <- as.POSIXct(x[[i]])
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
  
  #default is to drop the elements
  if(identical(na, "default")){
    na <- "NA";
  }
  
  #create a matrix of json elements
  dfnames <- deparse_vector(names(x))
  out <- vapply(x, asJSON, character(nrow(x)), collapse=FALSE, raw = "hex", na = na, complex=complex, ...)
  
  #this is a workaround for vapply simplifying into a vector for n=1 (not for n=0 surprisingly)
  if(!is.matrix(out)){
    out <- t(out)
  }
  
  #turn the matrix into json records
  if(na == "NA") {
    tmp <- apply(out, 1, function(z){
      missings <- is.na(z);
      if(any(missings)){
        paste("{", paste(dfnames[!missings], z[!missings], sep = " : ", collapse = ", "), "}")
      } else {
        paste("{", paste(dfnames, z, sep = " : ", collapse = ", "), "}")
      }
    });
  } else {
    #tiny speed up because we don't have to check for NA 
    tmp <- apply(out, 1, function(z){
      paste("{", paste(dfnames, z, sep = " : ", collapse = ", "), "}")
    });    
  }
  
  #collapse
  if(isTRUE(collapse)){
    collapse(tmp)
  } else {
    tmp
  }
}) 
