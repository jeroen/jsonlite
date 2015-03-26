collapse_object_r <- function(x, y, indent = 0){
  stopifnot(length(x) == length(y))
  missings <- is.na(y)
  if (any(missings)) {
    x <- x[!missings]
    y <- y[!missings]
  }
  # no pretty output; just paste names and values together
  if (is.na(indent)) {
    return(paste0("{", paste(x, y, sep = ":", collapse = ","), "}"))
  }
  s1 <- "{\n"
  s2 <- paste0("\n", spaces(indent), "}")
  paste0(s1, paste(spaces(indent + 2), sprintf("%s: %s", x, y), sep = "", collapse = ",\n"), s2)
}

#' @useDynLib jsonlite C_collapse_object
collapse_object_c <- function(x, y) {
  .Call(C_collapse_object, x, y)
}

collapse_object <- collapse_object_r
