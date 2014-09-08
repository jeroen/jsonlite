collapse_object_r <- function(names, values){
  stopifnot(length(names) == length(values))
  missings <- is.na(values);
  if(any(missings)){
    paste0("{", paste(names[!missings], values[!missings], sep = ":", collapse = ","), "}")
  } else {
    paste0("{", paste(names, values, sep = ":", collapse = ","), "}")
  }
}

#' @useDynLib jsonlite C_collapse_object
collapse_object_c <- function(x, y) {
  .Call(C_collapse_object, x, y)
}

collapse_object <- collapse_object_c;
