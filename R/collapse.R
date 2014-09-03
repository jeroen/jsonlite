collapse_r <- function(x){
  paste0("[", paste0(x, collapse = ","), "]")
}

#' @useDynLib jsonlite C_collapse_array
collapse_c <- function(x) {
  .Call("C_collapse_array", PACKAGE = "jsonlite", x)
}

collapse <- collapse_c;
