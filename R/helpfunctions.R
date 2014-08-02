# S4 to list object. Not quite sure if this really works in general. You probably
# shouldn't use S4 instances with JSON anyway because you don't know the class
# definition.

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

  #For these characters deparse() generates invalid JSON escape sequences
  #Compare ?Quotes and http://json.org/
  x <- gsub("[\v\a]", "", x)
  vapply(x, deparse, character(1), USE.NAMES=FALSE)
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
