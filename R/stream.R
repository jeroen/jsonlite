#' Streaming JSON input/output
#'
#' The \code{stream_in} and \code{stream_out} functions implement
#' line-by-line processing of JSON data over a \code{\link{connection}}, such as
#' a socket, url, file or pipe. This allows for processing unlimited amounts of data
#' with limited memory. JSON streaming assumes a slightly different format than
#' \code{\link{fromJSON}} and \code{\link{toJSON}}, see details for more information.
#'
#' Because parsing huge JSON strings is difficult and inefficient, JSON streaming
#' is done using \strong{lines of minified JSON records}, sometimes also called
#' \href{http://jsonlines.org/}{jsonlines}. This is pretty standard: JSON databases such
#' as MongoDB or \href{http://dat-data.com/}{dat} use the same format to import/export
#' large datasets. Note that this means that the total stream combined is
#' not valid JSON itself; only the individual lines are. Also note that because line-breaks
#' are used as separators, prettified JSON is not permitted: the JSON lines \emph{must}
#' be minified. In this respect, the format is a bit different from \code{\link{fromJSON}}
#' and \code{\link{toJSON}} where all lines are part of a single JSON structure with
#' optional line breaks.
#'
#' The \code{handler} is a callback function which is called for each page (batch) of
#' JSON data with exactly one argument (usually a data frame with \code{pagesize} rows).
#' If \code{handler} is missing or \code{NULL}, a default handler is used which stores all
#' intermediate pages of data in a list, and at the very end uses \code{\link{rbind.pages}}
#' to bind all pages together into one single data frame that is returned by \code{stream_in}.
#' When a custom \code{handler} function is specified, \code{stream_in}
#' does not store any intermediate results and always returns \code{NULL}.
#' It is then up to the \code{handler} to process and/or store data pages.
#' A \code{handler} function that does not store intermediate results in memory (for
#' example by writing output to another connection) results in a pipeline that can process an
#' unlimited amount of data. See example.
#'
#' If a connection is not opened yet, \code{stream_in} and \code{stream_out}
#' will automatically open and later close the connection. Because R destroys connections
#' when they are closed, they cannot be reused. To use a single connection for multiple
#' calls to \code{stream_in} or \code{stream_out}, it needs to be opened
#' beforehand. See example.
#'
#' @param con a \code{\link{connection}} object. If the connection is not open,
#' \code{stream_in} and \code{stream_out} will automatically open
#' and later close (and destroy) the connection. See details.
#' @param handler a custom function that is called on each page of JSON data. If not specified,
#' the default handler stores all pages and binds them into a single data frame that will be
#' returned by \code{stream_in}. See details.
#' @param x object to be streamed out. Currently only data frames are supported.
#' @param pagesize number of lines to read/write from/to the connection per iteration.
#' @param verbose print some information on what is going on.
#' @param ... arguments for \code{\link{fromJSON}} and \code{\link{toJSON}} that
#' control JSON formatting/parsing where applicable. Use with caution.
#' @name stream_in, stream_out
#' @aliases stream_in stream_out
#' @export stream_in stream_out
#' @rdname stream_in
#' @references MongoDB export format: \url{http://docs.mongodb.org/manual/reference/program/mongoexport/#cmdoption--query}
#' @references Documentation for the JSON Lines text file format: \url{http://jsonlines.org/}
#' @return The \code{stream_out} function always returns \code{NULL}.
#' When no custom handler is specified, \code{stream_in} returns a data frame of all pages binded together.
#' When a custom handler function is specified, \code{stream_in} always returns \code{NULL}.
#' @examples # compare formats
#' x <- iris[1:3,]
#' toJSON(x)
#' stream_out(x)
#'
#' \dontrun{stream large dataset to file and back
#' library(nycflights13)
#' stream_out(flights, file(tmp <- tempfile()))
#' flights2 <- stream_in(file(tmp))
#' unlink(tmp)
#' all.equal(flights2, as.data.frame(flights))
#'
#' # stream over HTTP
#' diamonds2 <- stream_in(url("http://jeroenooms.github.io/data/diamonds.json"))
#'
#' # stream over HTTP with gzip compression
#' flights3 <- stream_in(gzcon(url("http://jeroenooms.github.io/data/nycflights13.json.gz")))
#' all.equal(flights3, as.data.frame(flights))
#'
#' # stream over HTTPS (HTTP+SSL) via curl
#' library(curl)
#' flights4 <- stream_in(gzcon(curl("https://jeroenooms.github.io/data/nycflights13.json.gz")))
#' all.equal(flights4, as.data.frame(flights))
#'
#' # or alternatively:
#' flights5 <- stream_in(gzcon(pipe("curl https://jeroenooms.github.io/data/nycflights13.json.gz")))
#' all.equal(flights5, as.data.frame(flights))
#'
#' # Full JSON IO stream from URL to file connection.
#' # Calculate delays for flights over 1000 miles in batches of 5k
#' library(dplyr)
#' con_in <- gzcon(url("http://jeroenooms.github.io/data/nycflights13.json.gz"))
#' con_out <- file(tmp <- tempfile(), open = "wb")
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
#'
#' # Data from http://openweathermap.org/current#bulk
#' # Each row contains a nested data frame.
#' daily14 <- stream_in(gzcon(url("http://78.46.48.103/sample/daily_14.json.gz")), pagesize=50)
#' subset(daily14, city$name == "Berlin")$data[[1]]
#'
#' # Or with dplyr:
#' library(dplyr)
#' daily14f <- flatten(daily14)
#' filter(daily14f, city.name == "Berlin")$data[[1]]
#' }
stream_in <- function(con, handler, pagesize = 500, verbose = TRUE, ...) {

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
    if(verbose) message("opening ", is(con) ," input connection.")
    # binary prevents recoding of utf8 to latin1 on windows
    open(con, "rb")
    on.exit({
      if(verbose) message("closing ", is(con) ," input connection.")
      close(con)
    })
  }

  if(bind_pages){
    dfstack <- list();
  }

  i <- 1L;
  # JSON must be UTF-8 by spec
  while(length(page <- readLines(con, n = pagesize, encoding = "UTF-8"))){
    if(verbose) cat("\rFound", (i-1) * pagesize + length(page), "lines...")
    mydf <- simplify(lapply(page, parseJSON), ...);
    if(bind_pages){
      dfstack[[i]] <- mydf;
    } else {
      handler(mydf);
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

#' @rdname stream_in
stream_out <- function(x, con = stdout(), pagesize = 500, verbose = TRUE, ...) {

  if(!is(con, "connection")){
    # Maybe handle URLs here in future.
    stop("Argument 'con' must be a connection.")
  }

  if(!isOpen(con, "w")){
    if(verbose) message("opening ", is(con) ," output connection.")
    open(con, "wb")
    on.exit({
      if(verbose) message("closing ", is(con) ," output connection.")
      close(con)
    })
  }

  apply_by_pages(x, stream_out_page, pagesize = pagesize, con = con, verbose = verbose, ...);
}

stream_out_page <- function(page, con, ...){
  # useBytes can sometimes prevent recoding of utf8 to latin1 on windows.
  # on windows there is a bug when useBytes is used with a (non binary) text connection.
  writeLines(enc2utf8(asJSON(page, collapse = FALSE, ...)), con = con, useBytes = TRUE)
}
