setMethod("asJSON", "array", function(x, collapse = TRUE, na = NULL, oldna = NULL,
  matrix = c("rowmajor", "columnmajor"), auto_unbox = FALSE, keep_vec_names = FALSE,
  indent = NA_integer_, ...) {

  #validate
  matrix <- match.arg(matrix, choices = c("rowmajor", "columnmajor"));

  # reset na arg when called from data frame
  if(identical(na, "NA")){
    na <- oldna;
  }

  # 1D arrays are vectors
  if(length(dim(x)) < 2){
    return(asJSON(c(x), matrix = matrix, na = na, indent = indent + 2L, ...))
  }

  # if collapse == FALSE, then this matrix is nested inside a data frame,
  # and therefore row major is required to match dimensions
  # dont pass auto_unbox (never unbox within matrix)

  if(length(dim(x)) == 2 && identical(matrix, "rowmajor")){
    m <- asJSON(c(x), collapse = FALSE, matrix = matrix, na = na, ...)
    dim(m) <- dim(x)
    tmp <- row_collapse(m, indent = indent + 2L)
  } else {
    margin <- ifelse(identical(matrix, "columnmajor") && isTRUE(collapse), length(dim(x)), 1)
    tmp <- apply(x, margin, asJSON, matrix = matrix, na = na, indent = indent + 2L, ...)
  }

  # collapse it
  if (collapse) {
    collapse(tmp, inner = FALSE, indent = indent)
  } else {
    tmp
  }
})

# Some objects have class Matrix but not class Array
setMethod("asJSON", "matrix", getMethod("asJSON", "array"))
