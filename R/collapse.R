collapse_r <- function(x, inner = TRUE, indent = 0L){
  if (length(x) == 0) return("[]")
  # no pretty output
  if (is.na(indent)) return(paste0("[", paste0(x, collapse = ","), "]"))
  if (inner) {
    paste0("[", paste0(x, collapse = ", "), "]")
  } else {
    s1 <- "[\n"
    s2 <- paste0("\n", spaces(indent), "]")
    paste0(s1, paste0(spaces(indent + 2L), x, collapse = ",\n"), s2)
  }
}

#' @useDynLib jsonlite C_collapse_array C_collapse_array_indent
collapse_c <- function(x, inner = TRUE, indent = 0L) {
  if (is.na(indent)) {
    .Call(C_collapse_array, x)
  } else {
    .Call(C_collapse_array_indent, x, inner, indent)
  }
}

collapse <- collapse_c

spaces <- function(n, space = ' ') {
  if (n <= 0L) '' else paste0(rep(space, n), collapse = '')
}
