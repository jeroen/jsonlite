#' @useDynLib jsonlite C_collapse_array C_collapse_array_pretty_inner C_collapse_array_pretty_outer
collapse <- function(x, inner = TRUE, indent = 0L) {
  if(is.na(indent)){
    .Call(C_collapse_array, x)
  } else if(isTRUE(inner)){
    .Call(C_collapse_array_pretty_inner, x, indent)
  } else {
    .Call(C_collapse_array_pretty_outer, x, indent)
  }
}

#' @useDynLib jsonlite C_row_collapse_array
row_collapse <- function(m, indent = NA_integer_){
  .Call(C_row_collapse_array, m, indent = indent)
}
