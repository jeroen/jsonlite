#' Read and write MongoDB collections
#'
#' These functions are used to import or export MongoDB collections as a
#' data frames, and vice versa. Because BSON uses the same structures as
#' JSON, the mapping between BSON data and R classes is the same as for JSON.
#' The functions in jsonlite have been implemented to support streaming (batch
#' processing) in order to be able to handle large amounts of data with limited
#' memory.
#'
#' In mongo terminology, a set of records is called a \emph{collection} and it
#' maps to a data frame in R. A single record within the collection is called
#' a \emph{document}, and it maps to a row within the data frame. MongoDB uses
#' BSON, which extends the JSON format with some additional primitive types such
#' as integer, timestamp and binary. Storing data in its native types is a bit
#' more efficient in comparison with storing everything as text as is done for JSON.
#' However most of the time, the R user won't notice much difference between
#' BSON and JSON because the majority of most performance overhead happens
#' elsewhere.
#'
#' The main selling point of MongoDB is that we can easily store and access big
#' data. MongoDB is designed to store collections that are too large to hold in
#' memory, or even too large to store on a single disk by setting up a cluster.
#' MongoDB makes it easy to query, filter, sort, aggregate or map-reduce our (big)
#' data collections into something smaller and more managable that lends itself
#' to analysis and visualization in R.
#'
#' Interacting with MongoDB works very similar as JSON streaming. See the
#' \code{\link{stream_in}} manual page for details and examples of using
#' a custom \code{handler} function or IO pipe.
#'
#' @aliases mongo_read mongo_write
#' @export mongo_read mongo_write
#' @rdname mongo_read
#' @param mongo a mongo connection from \code{\link{mongo.create}}
#' @param ns a mongo namespace
#' @param a handler function
#' @param pagesize number of records (dataframe rows) per iteration
#' @param verbose some debugging output
#' @param ... additional parameters for \code{\link{mongo.find}} and \code{\link{fromJSON}}
#' (\code{mongo_read}) or for \code{\link{toJSON}} (\code{mongo_write}).
#' @return The \code{mongo_write} function always returns \code{NULL}.
#' When no custom handler is specified, \code{mongo_read} returns a data frame of
#' the entire collection (all pages binded together). When a custom handler
#' function is specified, \code{mongo_read} always returns \code{NULL}.
#' @examples \dontrun{
#' library(rmongodb)
#' library(nycflights13)
#' m <- mongo.create()
#' mongo_write(flights, m, "test.flights", pagesize = 1000)
#' mongo.count(m, "test.flights")
#' flights2 <- mongo_read(m, "test.flights", pagesize = 500)
#' all.equal(flights2, as.data.frame(flights))
#' mongo.remove(m, "test.flights")
#' }
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

mongo_find_internal <- function(mongo, ns, query = rmongodb::mongo.bson.empty(), skip = 0L,
  sort = '{"_row" : 1}', fields = '{"_id" : 0, "_row" : 0}', limit = 0L, options = 0L, ...) {

  # perform query
  cursor <- rmongodb::mongo.find (mongo = mongo, ns = ns, query = query, sort = sort,
    fields = fields, limit = limit, skip = skip, options = options);

  # clean up
  on.exit(rmongodb::mongo.cursor.destroy(cursor))

  # retrieve data
  mongo_process_records(cursor, ...)
}

mongo_process_records <- function(cursor, handler, pagesize, verbose, ...){

  # check if we use a custom handler
  bind_pages <- missing(handler) || is.null(handler);

  # what handler to use
  if(bind_pages){
    loadpkg("plyr")
  } else{
    stopifnot(is.function(handler))
    if(verbose) message("Using a custom handler function.")
  }

  # buffer
  if(bind_pages){
    dfstack <- list();
  }

  # iterate
  while(length(page <- mongo_read_page(cursor, pagesize))){
    if(verbose) message("Reading ", length(page), " lines (", length(dfstack)+1, ").")
    df <- simplify(page, ...);
    if(bind_pages){
      dfstack[[length(dfstack)+1]] <- df;
    } else {
      handler(df);
    }
  }

  # Warn for no data
  if(verbose && !length(dfstack)) message("Query returned no data.")

  # Either return a big data frame, or nothing.
  if(bind_pages){
    if(verbose && length(dfstack)) message("Binding pages together (no custom handler).")
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
