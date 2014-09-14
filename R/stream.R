#' Streaming JSON input/output
#'
#' The \code{stream_in} and \code{stream_out} functions implement
#' line-by-line processing of JSON data over a \code{\link{connection}}, such as
#' a socket, url, file or pipe. This allows for processing unlimited amounts of data
#' with limited memory. JSON streaming assumes a slightly different format than
#' \code{\link{fromJSON}} and \code{\link{toJSON}}, see details for more information.
#'
#' Because parsing huge JSON strings is difficult and inefficient, JSON streaming
#' is done using \strong{lines of minified JSON records}. This is pretty
#' standard: JSON databases such as MongoDB use the same format to import/export
#' large datasets. Note that this means that the total stream combined is in itself
#' not valid JSON; only the individual lines are. Also note that because line-breaks
#' are used as separators, prettified JSON is not permitted: the JSON lines \emph{must}
#' be minified. In this respect, the format is a bit different from \code{\link{fromJSON}}
#' and \code{\link{toJSON}} where all lines are part of a single JSON structure, and
#' line breaks are optional.
#'
#' The \code{handler} is a callback function which is called for each page (batch) of
#' JSON data with exactly one argument (usually a data frame with \code{pagesize} rows).
#' If \code{handler} is missing or \code{NULL}, a default handler is used which stores all
#' intermediate pages of data in a list, and at the very end uses \code{\link{rbind.pages}}
#' to bind all pages together into one single data frame that is returned by \code{\link{stream_in}}.
#' On the other hand, when a custom \code{handler} function is specified, \code{stream_in}
#' does not store any intermediate results and returns \code{NULL}.
#' It is then assumed that the \code{handler} takes care of processing intermediate pages.
#' A \code{handler} function that does not store intermediate results in memory (for
#' example by writing output to another connection) results in a pipeline that can process an
#' unlimited amount of data. See example.
#'
#' If a connection is not opened yet, \code{stream_in} and \code{stream_out}
#' will automatically open and later close the connection. Because R destroys connections
#' when they are closed, they cannot be reused. To reuse a connection object for multiple
#' calls to \code{stream_in} and \code{stream_out}, it needs to be opened beforehand. See
#' example.
#'
#' @param con A \code{\link{connection}} object. If the connection is not open,
#' \code{stream_in} and \code{stream_out} will automatically open
#' and later close (and destroy) the connection. See details.
#' @param handler a custom function that is called on each page of JSON data. If not specified,
#' the default handler stores all pages and binds them into a single data frame that will be
#' returned by \code{stream_in}. See details.
#' @param pagesize number of lines to read/write from/to the connection per iteration.
#' @param verbose print some information on what is going on.
#' @param ... arguments passed to \code{\link{fromJSON}} and \code{\link{toJSON}} to
#' control JSON formatting/parsing where applicable. Use with caution.
#' @name stream_in, stream_out
#' @aliases stream_in stream_out
#' @export stream_in stream_out
#' @return \code{stream_out} always returns \code{NULL}.
#' When a custom handler function is specified, \code{stream_in} returns \code{NULL}.
#' When no custom handler is specified, \code{stream_in} returns a data frame of all pages
#' binded together.
#' @examples # compare formats
#' x <- iris[1:3,]
#' toJSON(x)
#' stream_out(x)
#'
#' \dontrun{
#' # stream large dataset to file and back
#' library(nycflights13)
#' stream_out(flights, file(tmp <- tempfile()), pagesize = 200)
#' flights2 <- stream_in(file(tmp))
#' unlink(tmp)
#' all.equal(flights2, as.data.frame(flights))
#'
#' # stream from HTTP
#' flights3 <- stream_in(gzcon(url("http://jeroenooms.github.io/data/nycflights13.mjson.gz")))
#' all.equal(flights3, as.data.frame(flights))
#'
#' #stream HTTPS (HTTP+SSL) via curl pipe
#' flights4 <- stream_in(gzcon(pipe("curl https://jeroenooms.github.io/data/nycflights13.mjson.gz")))
#' all.equal(flights4, as.data.frame(flights))
#'
#' # Full JSON stream IO: stream from URL to file.
#' # Calculate delays for flights over 1000 miles in batches of 5k
#' library(dplyr)
#' con_in <- gzcon(url("http://jeroenooms.github.io/data/nycflights13.mjson.gz"))
#' con_out <- file(tmp <- tempfile(), open = "w")
#' stream_in(con_in, handler = function(df){
#'   df <- dplyr::filter(df, distance > 1000)
#'   df <- dplyr::mutate(df, delta = dep_delay - arr_delay)
#'   stream_out(df, con_out, pagesize = 1000)
#' }, pagesize = 5000)
#' close(con_out)
#'
#' # stream it back in
#' mydata <- stream_in(file(tmp))
#' nrow(mydata)
#' unlink(tmp)
#' }
stream_in <- function(con, handler, pagesize = 100, verbose = TRUE, ...) {

  # check if we use a custom handler
  bind_pages <- missing(handler) || is.null(handler);

  if(!is(con, "connection")){
    # Maybe handle URLs here in future.
    stop("Argument 'con' must be a connection.")
  }

  if(bind_pages){
    loadpkg("plyr")
  } else{
    stopifnot(is.function(handler))
    if(verbose) message("using a custom handler function.")
  }

  if(!isOpen(con, "r")){
    if(verbose) message("opening ", is(con) ," connection.")
    open(con, "r")
    on.exit({
      if(verbose) message("closing ", is(con) ," connection.")
      close(con)
    })
  }

  if(bind_pages){
    dfstack <- list();
  }

  i <- 1L;
  while(length(page <- readLines(con, n = pagesize))){
    if(verbose) message("Reading ", length(page), " lines (", i,").")
    mydf <- import_json_page(page, ...);
    if(!missing(handler)) handler(mydf);
    if(bind_pages){
      dfstack[[i]] <- mydf;
    }
    i <- i + 1L;
  }

  # Either return a big data frame, or nothing.
  if(bind_pages){
    if(verbose) message("binding pages together (no custom handler).")
    rbind.pages(dfstack)
  } else {
    invisible();
  }
}

stream_out <- function(x, con = stdout(), pagesize = 100, verbose = TRUE, ...) {

  if(!is(con, "connection")){
    # Maybe handle URLs here in future.
    stop("Argument 'con' must be a connection.")
  }

  if(!isOpen(con, "w")){
    if(verbose) message("opening ", is(con) ," connection.")
    open(con, "w")
    on.exit({
      if(verbose) message("closing ", is(con) ," connection.")
      close(con)
    })
  }

  stopifnot(is.data.frame(x))
  nr <- nrow(x)
  npages <- nr %/% pagesize;
  lastpage <- nr %% pagesize;

  for(i in seq_len(npages)){
    from <- pagesize * (i-1) + 1;
    to <- pagesize * i
    if(verbose) message("Writing ", pagesize, " lines (",i ,").")
    stream_out_page(x[from:to, ,drop = FALSE], con = con, verbose = verbose, ...)
  }
  if(lastpage){
    from <- nr - lastpage + 1;
    if(verbose) message("Writing ", lastpage, " lines.")
    stream_out_page(x[from:nr, ,drop = FALSE], con = con, verbose = verbose, ...)
  }

  invisible();
}

stream_out_page <- function(page, con, ...){
  writeLines(asJSON(page, collapse = FALSE, ...), con = con)
}
