collapse_r <- function(x, inner = TRUE, indent = 0){
  if (length(x) == 0) return("[]")
  if (inner) {
    s1 <- "["
    s2 <- "]"
  } else {
    s1 <- "[\n"
    s2 <- paste0("\n", spaces(indent), "]")
  }
  paste0(s1, paste0(if (!inner) spaces(indent + 2), x, collapse = if (inner) ', ' else ',\n'), s2)
}

#' @useDynLib jsonlite C_collapse_array
collapse_c <- function(x) {
  .Call(C_collapse_array, x)
}

collapse <- collapse_r

spaces <- function(n, space = ' ') {
  if (n <= 0) '' else paste0(rep(space, n), collapse = '')
}
