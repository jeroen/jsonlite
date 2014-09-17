#' @rdname mongo_read
mongo_write <- function(x, mongo, ns, pagesize = 100, verbose = TRUE, ...){
  # basic validation
  stopifnot(is.data.frame(x))
  stopifnot(is.character(ns))
  stopifnot(rmongodb::mongo.is.connected(mongo))
  apply_by_pages(x, mongo_write_page, pagesize = pagesize, verbose = verbose,
    ns = ns, mongo = mongo, ...)
}

mongo_write_page <- function(x, ns, mongo, ...){
  jsonlist <- parseJSON(asJSON(x, ...))
  records <- lapply(jsonlist, mongo_create_record)
  rmongodb::mongo.insert.batch(mongo, ns, records)
}

# This is a temporary hack because mongo.bson.from.list does not work for lists of length 0
mongo_create_record <- function(x){
  if(length(x)){
    rmongodb::mongo.bson.from.list(x)
  } else {
    rmongodb::mongo.bson.empty()
  }
}
