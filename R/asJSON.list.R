setMethod("asJSON", "list", function(x, collapse = TRUE, ...) {
  
  # We are explicitly taking the container argument to prevent it from being passed
  # down through ... (elipse) As scalar should never be applied to an entire list
  # (unless it is POSIXlt or so)
  
  # coerse pairlist if needed
  if (is.pairlist(x)) {
    x <- as.vector(x, mode = "list")
  }
  
  # Emtpy list:
  if (length(x) == 0) {
    return(if (is.null(names(x))) "[]" else "{}")
  }
  
  # this condition appears when a dataframe contains a column with lists we need to
  # do this, because the [ operator always returns a list of length 1
  if (length(x) == 1 && is.null(names(x)) && collapse == FALSE) {
    return(asJSON(x[[1]], ...))
  }
  
  # note we are NOT passing on the container argument.
  tmp <- vapply(x, asJSON, character(1), ...)
  
  # this seems redundant??
  if (all(sapply(tmp, is.name))) {
    names(tmp) <- NULL
  }
  
  if (length(names(x))) {
    #in case of named list:    
    objnames <- names(x)
    objnames[objnames == ""] <- as.character(1:length(objnames))[objnames == ""]
    objnames <- make.unique(objnames)
    paste("{", paste(deparse_vector(objnames), tmp, sep = " : ", collapse = ", "), "}")
  } else {
    #in case of unnamed list:
    if(collapse){
      #collapse(tmp)
      paste("[", paste0(tmp, collapse = ","), "]")
    } else {
      tmp
    }
  }
}) 
