setMethod("asJSON", "list", function(x, collapse = TRUE, ...) {

  # coerse pairlist if needed
  if (is.pairlist(x)) {
    x <- as.vector(x, mode = "list")
  }
  
  # empty vector
  #if (!length(x)) {
  #  if(collapse) {
  #    return(if (is.null(names(x))) "[]" else "{}")
  #  } else {
  #    return(character())
  #  }
  #}
  
  # this condition appears when a dataframe contains a column with lists we need to
  # do this, because the [ operator always returns a list of length 1
  # if (length(x) == 1 && is.null(names(x)) && collapse == FALSE) {
  #   return(asJSON(x[[1]], ...))
  # }
  
  # note we are NOT passing on the container argument.
  tmp <- vapply(x, asJSON, character(1), ...)
  
  if (!is.null(names(x))) {
    if(!collapse){
      #this should never happen
      warning("collapse=FALSE called for named list.")
    }
    #in case of named list:    
    objnames <- names(x)
    objnames[objnames == ""] <- as.character(1:length(objnames))[objnames == ""]
    objnames <- make.unique(objnames)
    paste("{", paste(deparse_vector(objnames), tmp, sep = " : ", collapse = ", "), "}")
  } else {
    #in case of unnamed list:
    if(collapse){
      collapse(tmp)
    } else {
      tmp
    }
  }
}) 
