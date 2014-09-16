mongo_write <- function(x, mongo, ns, pagesize = 100, verbose = TRUE, ...){
  #iterate over 100 rows at a time:
    #jslist <- parseJSON(asJSON(x[from:to,,drop=FALSE], ...))
    #mongo.insert(mongo, ns, mongo.bson.from.list(jslist))
}

mongo_read <- function(mongo, ns, handler, pagesize = 100, verbose = TRUE, ...){
  #mongo.find(...)
  # iterate per 100 lines
  # page <- lapply(values, mongo.bson.to.list)
  # simplify(page, ...)
}

mongo_find_internal <- function(mongo, ns, query = NULL, sort = rmongodb::mongo.bson.empty(),
  fields = rmongodb::mongo.bson.empty(), limit = 0L, skip = 0L, options = 0L, ...) {
  cursor <- mongo.find (
    mongo = mongo,
    ns = ns,
    sort = sort,
    fields = fields,
    limit = limit,
    skip = skip,
    options = options
  );
  mongo_process_internal(cursor, ...)
}

mongo_process_intenral <- function(cursor, pagesize, verbose, ...){
  results <- list();
  while (mongo.cursor.next(cursor)) {
    results[[length(results)+1]] <- mongo.bson.to.list(mongo.cursor.value(cursor));
  }
  simplify(results, ...)
}
