# Default to 100kb chunks.
parse_con <- function(con, n = 100 * 1024){
  stopifnot(is(con, "connection"))
  if(!isOpen(con)){
    open(con, "rb")
    on.exit(close(con))
  }
  reset_push_parser();
  while(length(buf <- readBin(con, raw(), n))){
    feed_push_parser(buf)
  }
  finalize_push_parser()
}

#' @useDynLib jsonlite R_reset_push_parser
reset_push_parser <- function(){
  .Call(R_reset_push_parser)
}

#' @useDynLib jsonlite R_feed_push_parser
feed_push_parser <- function(data){
  if(is.character(data)){
    data <- charToRaw(data)
  }
  stopifnot(is.raw(data))
  .Call(R_feed_push_parser, data)
}

#' @useDynLib jsonlite R_finalize_push_parser
finalize_push_parser <- function(){
  .Call(R_finalize_push_parser)
}
