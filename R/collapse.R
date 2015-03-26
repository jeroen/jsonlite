collapse_r <- function(x, inner = TRUE, indent = 0){
  if (length(x) == 0) return("[]")
  # no pretty output
  if (is.na(indent)) return(paste0("[", paste0(x, collapse = ","), "]"))
  if (inner) {
    paste0("[", paste0(x, collapse = ", "), "]")
  } else {
    s1 <- "[\n"
    s2 <- paste0("\n", spaces(indent), "]")
    paste0(s1, paste0(spaces(indent + 2), x, collapse = ",\n"), s2)
  }
}

#' @useDynLib jsonlite C_collapse_array
collapse_c <- function(x) {
  .Call(C_collapse_array, x)
}

collapse <- collapse_r

spaces <- function(n, space = ' ') {
  if (n <= 0) '' else paste0(rep(space, n), collapse = '')
}
