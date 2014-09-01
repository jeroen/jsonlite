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
deparse_vector_old <- function(x) {
  stopifnot(is.character(x))
  x <- gsub("[\v\a]", "", x)
  vapply(x, deparse, character(1), USE.NAMES=FALSE)
}

# this version is ugly but much faster
deparse_vector <- function(x) {
  stopifnot(is.character(x))
  if(!length(x)) return(x)
  x <- gsub("\\", "\\\\", x, fixed=TRUE)
  x <- gsub("\"", "\\\"", x, fixed=TRUE)
  x <- gsub("\n", "\\n", x, fixed=TRUE)
  x <- gsub("\r", "\\r", x, fixed=TRUE)
  x <- gsub("\t", "\\t", x, fixed=TRUE)
  x <- gsub("\b", "\\b", x, fixed=TRUE)
  x <- gsub("\f", "\\f", x, fixed=TRUE)
  paste0("\"", x, "\"")
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
