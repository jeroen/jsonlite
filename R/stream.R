#' Stream JSON input/output
#'
#' @export
#' @examples library(nycflights13)
#' stream_out(flights, file(tmp <- tempfile()), pagesize = 200)
#' flights2 <- stream_in(file(tmp))
#' unlink(tmp)
#' all.equal(flights2, as.data.frame(flights))
stream_in <- function(con, handler, pagesize = 100, verbose = TRUE, ...) {

  # check if we use a custom handler
  bind_pages <- missing(handler) || is.null(handler);

  if(!is(con, "connection")){
    # Maybe handle URLs here in future.
    stop("Argument 'con' must be a connection.")
  }

  if(!bind_pages){
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
