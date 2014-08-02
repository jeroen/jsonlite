simplifyDataFrame <- function(recordlist, columns, flatten, simplifyMatrix) {

  # no records at all
  if (!length(recordlist)) {
    if (!missing(columns)) {
      return(as.data.frame(matrix(ncol = length(columns), nrow = 0, dimnames = list(NULL,
        columns))))
    } else {
      return(data.frame())
    }
  }

  # only empty records and unknown columns
  if (!any(unlist(vapply(recordlist, length, integer(1)))) && missing(columns)) {
    return(data.frame(matrix(nrow = length(recordlist), ncol = 0)))
  }

  # flatten list if set must be a more efficient way to do this. also 'null' values
  # get lost (although they might come back later) also breaks when records contain
  # nested lists of variable length
  #if (isTRUE(flatten)) {
  #  recordlist <- lapply(recordlist, function(mylist) {
  #    lapply(rapply(mylist, base::enquote, how = "unlist"), eval)
  #  })
  #}

  # find columns if not specified
  if (missing(columns)) {
    columns <- unique(unlist(lapply(recordlist, names)))
  }

  # make new recordlist with requested only requested values
  recordlist <- lapply(recordlist, function(x) {
    # a new record with each requested column
    y <- structure(as.list(x)[columns], names = columns)

    # replace NULL with NA values in each record lapply(y, function(z) {
    # if(is.null(z)) NA else z; })
  })

  # create a list of lists
  columnlist <- lapply(columns, function(x) lapply(recordlist, "[[", x))
  names(columnlist) <- columns

  # simplify vectors and nested data frames
  columnlist <- lapply(columnlist, simplify, simplifyVector = TRUE, simplifyDataFrame = TRUE,
    simplifyMatrix = FALSE, simplifySubMatrix = simplifyMatrix, flatten = flatten)

  # columnlist <- lapply(columnlist, function(x){ if(is.scalarlist(x)){
  # return(null2na(x)) } else if(is.recordlist(x)) { return(simplifyDataFrame(x,
  # flatten=flatten)); } else { return(x); } });

  # check that all elements have equal length
  columnlengths <- unlist(vapply(columnlist, function(z) {
    ifelse(length(dim(z)) > 1, nrow(z), length(z))
  }, integer(1)))
  n <- unique(columnlengths)
  if (length(n) > 1) {
    stop("Elements not of equal length: ", paste(columnlengths, collapse = " "))
  }

  # flatten nested data frames
  if(isTRUE(flatten)) {
    dfcolumns <- vapply(columnlist, is.data.frame, logical(1))
    if(any(dfcolumns)){
      columnlist <- c(columnlist[!dfcolumns], do.call(c, columnlist[dfcolumns]))
    }
  }

  # make into data frame
  return(structure(columnlist, class = "data.frame", row.names = 1:n))
}
