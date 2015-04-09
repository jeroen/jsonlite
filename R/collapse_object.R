#' @useDynLib jsonlite C_collapse_object C_collapse_object_pretty
collapse_object <- function(x, y, indent = 0L) {
  if(is.na(indent)){
    .Call(C_collapse_object, x, y)
  } else {
    .Call(C_collapse_object_pretty, x, y, indent)
  }
}
