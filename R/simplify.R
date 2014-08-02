simplify <- function(x, simplifyVector = TRUE, simplifyDataFrame = TRUE, simplifyMatrix = TRUE,
  simplifyDate = simplifyVector, homoList = TRUE, flatten = FALSE, columnmajor = FALSE,
  simplifySubMatrix = simplifyMatrix) {
  if (is.list(x)) {
    if (!length(x)) {
      # In case of fromJSON('[]') returning a list is most neutral.  Because the user
      # can do as.vector(list()) and as.data.frame(list()) which both results in the
      # correct object.
      return(list())
    }

    # list can be a dataframe recordlist
    if (isTRUE(simplifyDataFrame) && is.recordlist(x)) {
      mydf <- simplifyDataFrame(x, flatten = flatten, simplifyMatrix = simplifySubMatrix)
      if(isTRUE(simplifyDate) && is.data.frame(mydf) && is.datelist(mydf)){
        return(structure(mydf[["$date"]]/1000, class=c("POSIXct", "POSIXt")))
      }
      if ("$row" %in% names(mydf)) {
        row.names(mydf) <- mydf[["$row"]]
        mydf["$row"] <- NULL
      }
      return(mydf)
    }

    # or a scalar list (atomic vector)
    if (isTRUE(simplifyVector) && is.null(names(x)) && is.scalarlist(x)) {
      return(null2na(x))
    }

    # apply recursively
    out <- lapply(x, simplify, simplifyVector = simplifyVector, simplifyDataFrame = simplifyDataFrame,
      simplifyMatrix = simplifySubMatrix, columnmajor = columnmajor, flatten = flatten)

    # fix for mongo style dates turning into scalars *after* simplifying
    # only happens when simplifyDataframe=FALSE
    if(isTRUE(simplifyVector) && is.scalarlist(out) && all(vapply(out, is, logical(1), "POSIXt"))){
      return(structure(null2na(out), class=c("POSIXct", "POSIXt")))
    }

    # test for matrix. Note that we have to take another look at x (before null2na on
    # its elements) to differentiate between matrix and vector
    if (isTRUE(simplifyMatrix) && isTRUE(simplifyVector) && is.matrixlist(out) && all(unlist(vapply(x, is.scalarlist, logical(1))))) {
      if(isTRUE(columnmajor)){
        return(do.call(cbind, out))
      } else {
        #this is currently the default
        return(do.call(rbind, out))
      }
    }

    # Simplify higher arrays
    if (isTRUE(simplifyMatrix) && is.arraylist(out)){
      if(isTRUE(columnmajor)){
        return(array(
          data = do.call(cbind, out),
          dim = c(dim(out[[1]]), length(out))
        ));
      } else {
        #this is currently the default
        return(array(
          data = do.call(rbind, lapply(out, as.vector)),
          dim = c(length(out), dim(out[[1]]))
        ));
      }
    }

    # try to enfoce homoList on unnamed lists
    if (isTRUE(homoList) && is.null(names(out))) {
      # coerse empty lists, caused by the ambiguous fromJSON('[]')
      isemptylist <- vapply(out, identical, logical(1), list())
      if (any(isemptylist) & !all(isemptylist)) {
        # if all the others look like data frames, coerse to data frames!
        if (all(vapply(out[!isemptylist], is.data.frame, logical(1)))) {
          for (i in which(isemptylist)) {
          out[[i]] <- data.frame()
          }
          return(out)
        }

        # if all others look like atomic vectors, unlist all
        if (all(vapply(out[!isemptylist], function(z) {
          isTRUE(is.vector(z) && is.atomic(z))
        }, logical(1)))) {
          for (i in which(isemptylist)) {
          out[[i]] <- vector(mode = typeof(out[[which(!isemptylist)[1]]]))
          }
          return(out)
        }
      }
    }

    # convert date object
    if( isTRUE(simplifyDate) && is.datelist(out) ){
      return(structure(out[["$date"]]/1000, class=c("POSIXct", "POSIXt")))
    }

    # return object
    return(out)
  } else {
    return(x)
  }
}

is.scalarlist <- function(x) {
  isTRUE(is.list(x) && all(sapply(x, function(y) {
    mode(y) %in% c("numeric", "logical", "character", "complex", "NULL") && (length(y) <=
      1)
  })))
}

is.namedlist <- function(x) {
  isTRUE(is.list(x) && !is.null(names(x)))
}

is.unnamedlist <- function(x) {
  isTRUE(is.list(x) && is.null(names(x)))
}

is.recordlist <- function(x) {
  # recordlist is an array with only objects or NULL NULL appears when this is a
  # nested data frame, but some records do not contain this data frame at all.
  if (!isTRUE(is.unnamedlist(x) && length(x))) {
    return(FALSE)
  }
  if (!any(namedlists <- vapply(x, is.namedlist, logical(1)))) {
    return(FALSE)
  }
  return(isTRUE(all(namedlists | vapply(x, is.null, logical(1)))))
}

is.matrixlist <- function(x) {
  isTRUE(is.list(x)
    && length(x)
    && is.null(names(x))
    && all(vapply(x, is.atomic, logical(1)))
    && all.identical(vapply(x, length, integer(1)))
    #&& all.identical(vapply(x, mode, character(1))) #this fails for: [ [ 1, 2 ], [ "NA", "NA" ] ]
  );
}

is.arraylist <- function(x) {
  isTRUE(is.list(x)
    && length(x)
    && is.null(names(x))
    && all(vapply(x, is.array, logical(1)))
    && all.identical(vapply(x, function(y){paste(dim(y), collapse="-")}, character(1)))
  );
}

is.datelist <- function(x){
  isTRUE(is.list(x)
     && identical(names(x), "$date")
     && is.numeric(x[["$date"]])
  );
}

all.identical <- function(x){
  length(unique(x)) == 1
}
