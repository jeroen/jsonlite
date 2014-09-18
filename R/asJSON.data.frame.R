setMethod("asJSON", "data.frame", function(x, na = c("NA", "null", "string"), collapse = TRUE,
  dataframe = c("rows", "columns"), complex = "string", oldna = NULL, rownames = NULL, ...) {

  # Validate some args
  dataframe <- match.arg(dataframe)

  # Coerse pairlist if needed
  if (is.pairlist(x)) {
    x <- as.vector(x, mode = "list")
  }

  # Add row names only if strings (not integers)
  if(isTRUE(rownames) || (is.null(rownames) && is.character(attr(x, "row.names")))){
    # we don't use row.names() because this converts numbers to strings,
    # which will break sorting
    x[["_row"]] <- attr(x, "row.names")
  }

  # Unname named lists columns. These are very rare.
  namedlistvars <- which(vapply(x, is.namedlistnotdf, logical(1)))
  for (i in namedlistvars) {
    x[[i]] <- unname(x[[i]])
  }

  # Convert POSIXlt to POSIXct before we start messing with lists
  posvars <- which(vapply(x, is, logical(1), "POSIXlt"))
  for (i in posvars) {
    x[[i]] <- as.POSIXct(x[[i]])
  }

  # Colum based is same as list based
  if (dataframe == "columns") {
    return(asJSON(as.list(x), is_df = TRUE, na = na, collapse = collapse, dataframe = dataframe,
      complex = complex, rownames = rownames, ...))
  }

  # Determine "oldna". This is needed when the data frame contains a list column
  if(missing(na) || !length(na) || identical(na, "NA")){
    oldna <- NULL
  } else {
    oldna <- na;
  }

  # Set default for row based, don't do it earlier because it will affect 'oldna' or dataframe="columns"
  na <- match.arg(na)

  # no records
  if (!nrow(x)) {
    return(asJSON(list(), collapse=collapse))
  }

  # Convert raw vectors
  rawvars <- which(vapply(x, is.raw, logical(1)))
  for (i in rawvars) {
    x[[i]] <- as.character.hexmode(x[[i]])
  }

  # Turn complex vectors into data frames
  if(complex == "list"){
    complxvars <- which(vapply(x, is.complex, logical(1)))
    for (i in complxvars) {
      x[[i]] <- data.frame(real=Re(x[[i]]), imaginary=Im(x[[i]]))
    }
  }

  #create a matrix of json elements
  dfnames <- deparse_vector(cleannames(names(x)))
  out <- vapply(x, asJSON, character(nrow(x)), collapse=FALSE, complex = complex, na = na,
    oldna = oldna, rownames = rownames, ..., USE.NAMES = FALSE)

  # This would be another way of doing the missing values
  # This does not require the individual classes to support na="NA"
  #if(identical(na, "NA")){
  #  namatrix <- vapply(x, is.na, logical(nrow(x)))
  #  out[namatrix] <- NA;
  #}

  #this is a workaround for vapply simplifying into a vector for n=1 (not for n=0 surprisingly)
  if(!is.matrix(out)){
    out <- t(out)
  }

  #turn the matrix into json records
  tmp <- apply(out, 1, collapse_object, x = dfnames);

  #collapse
  if(isTRUE(collapse)){
    collapse(tmp)
  } else {
    tmp
  }
})

is.namedlistnotdf <- function(x){
  isTRUE(is.list(x) && !is.data.frame(x) && !is.null(names(x)))
}
