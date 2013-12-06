# S4 to list object. Not quite sure if this really works in general. You probably shouldn't use S4 instances with JSON
# anyway because you don't know the class definition.

S4tolist <- function(x) {
  structure(lapply(slotNames(x), slot, object = x), .Names = slotNames(x))
}

# ENCODING TOOLS

# opposite of unname: force list into named list to get key/value json encodings
givename <- function(obj) {
  return(structure(obj, names = as.character(names(obj))))
}

# vectorized deparse
deparse_vector <- function(x) {
  stopifnot(is.character(x))
  vapply(as.list(x), deparse, character(1))
}

# trim whitespace
trim <- function(x) {
  gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)
}

# put double quotes around a string
wrapinquotes <- function(x) {
  paste("\"", x, "\"", sep = "")
}

# DECODING TOOLS
evaltext <- function(text) {
  return(eval(parse(text = text)))
}

null2na <- function(x, unlist = TRUE) {
  if (!length(x)) {
    if (isTRUE(unlist)) {
      return(vector())
    } else {
      return(list())
    }
  }
  # parse explicitly quoted missing values, unless in the case of character vectors
  if (!isTRUE(any(vapply(x, function(y) {
    is.character(y) && !(y %in% c("NA", "Inf", "-Inf", "NaN"))
  }, logical(1))))) {
    missings <- x %in% c("NA", "Inf", "-Inf", "NaN")
    x[missings] <- lapply(x[missings], evaltext)
  }
  
  # parse 'null' values
  x[unlist(sapply(x, is.null))] <- NA
  if (isTRUE(unlist)) {
    return(unlist(x))
  } else {
    return(x)
  }
} 
