mongo_read <- function(mongo, ns, handler, pagesize = 100, verbose = TRUE, ...){
  stopifnot(rmongodb::mongo.is.connected(mongo))
  stopifnot(is.character("ns"))
  if(missing(handler)){
    handler <- NULL
  } else {
    stopifnot(is.function(handler))
  }

  # Pass on request to work horse
  mongo_find_internal(mongo = mongo, ns = ns, handler = handler, pagesize = pagesize,
    verbose = verbose, ...)
}

mongo_find_internal <- function(mongo, ns, query = rmongodb::mongo.bson.empty(),
  sort = rmongodb::mongo.bson.empty(), fields = '{"_id": 0}', limit = 0L,
  skip = 0L, options = 0L, ...) {

  # perform query
  cursor <- rmongodb::mongo.find (mongo = mongo, ns = ns, query = query, sort = sort,
    fields = fields, limit = limit, skip = skip, options = options);

  # retrieve data
  mongo_process_records(cursor, ...)
}

mongo_process_records <- function(cursor, handler, pagesize = 100, verbose = TRUE, ...){

  # check if we use a custom handler
  bind_pages <- missing(handler) || is.null(handler);

  # what handler to use
  if(bind_pages){
    loadpkg("plyr")
  } else{
    stopifnot(is.function(handler))
    if(verbose) message("using a custom handler function.")
  }

  # buffer
  if(bind_pages){
    dfstack <- list();
  }

  # iterate
  while(length(page <- mongo_read_page(cursor, pagesize))){
    df <- simplify(page, ...);
    if(bind_pages){
      dfstack[[length(dfstack)+1]] <- df;
    } else {
      handler(df);
    }
  }

  # Either return a big data frame, or nothing.
  if(bind_pages){
    if(verbose) message("binding pages together (no custom handler).")
    rbind.pages(dfstack)
  } else {
    invisible();
  }
}

mongo_read_page <- function(cursor, pagesize){
  records <- list();
  for(i in seq_len(pagesize)){
    if(rmongodb::mongo.cursor.next(cursor)){
      records[[i]] <- rmongodb::mongo.bson.to.list(rmongodb::mongo.cursor.value(cursor))
    } else {
      break;
    }
  }
  return(records)
}
