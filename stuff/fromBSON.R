#' Convert a mongo.bson object to an R object.
#'
#' This function uses \code{mongo.bson.to.list} from the \code{rmongodb} package
#' to read a \code{BSON} object, and then uses \code{jsonlite} the same mapping as for
#' \code{JSON} objects to convert it into an R object.
#'
#' @param b A \code{mongo.bson} object. Passed to \code{mongo.bson.to.list}. See package \code{rmongodb}.
#' @param simplifyVector coerse JSON arrays containing only scalars into a vector
#' @param simplifyDataFrame coerse JSON arrays containing only records (JSON objects) into a data frame.
#' @param simplifyMatrix coerse JSON arrays containing vectors of equal length and mode into matrix or array.
#' @param ... arguments passed on to class specific \code{print} methods
#' @export
fromBSON <- function(b, simplifyVector = TRUE, simplifyDataFrame = simplifyVector,
  simplifyMatrix = simplifyVector, ...){

  #load rmongodb if not loaded
  obj <- rmongodb::mongo.bson.to.list(b)

  # post processing
  if (any(isTRUE(simplifyVector), !is.null(simplifyDataFrame), isTRUE(simplifyMatrix))) {
    return(simplify(obj, simplifyVector = simplifyVector, simplifyDataFrame = simplifyDataFrame,
      simplifyMatrix = simplifyMatrix, ...))
  } else {
    return(obj)
  }
}

mongoquery <- function(mongo, ns, ...){
  cursor <- mongo.find(mongo, ns, ...);
  results <- list();
  while (mongo.cursor.next(cursor)) {
    b <- mongo.cursor.value(cursor);
    results[[length(results)+1]] <- mongo.bson.to.list(b);
  }
  jsonlite:::simplify(results)
}

