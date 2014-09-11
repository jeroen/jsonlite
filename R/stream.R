#' Stream JSON input/output
#'
#' @export
#' @examples library(hflights)
#' row.names(hflights) <- NULL
#' stream_out(hflights, file(tmp <- tempfile()), pagesize = 200)
#' hf2 <- stream_in(file(tmp))
#' unlink(tmp)
#' all.equal(hflights, hf2)
stream_in <- function(con, handler, pagesize = 100, verbose = TRUE, ...) {

  # check if we use a custom handler
  bind_pages <- missing(handler) || is.null(handler);
  con_opened = FALSE;

  if(!is(con, "connection")){
    # Maybe handle URLs here in future.
    stop("Argument 'con' must be a connection.")
  }

  if(!bind_pages){
    stopifnot(is.function(handler))
    if(verbose) message("using a custom handler function.")
  }

  if(!isOpen(con, "r")){
    if(verbose) message("opening connection.")
    con_opened <- TRUE;
    open(con, "r")
  }

  if(bind_pages){
    dfstack <- list();
  }

  i <- 1L;
  while(length(page <- readLines(con, n = pagesize))){
    if(verbose) message("Page ", i, ": found ", length(page), " lines.")
    mydf <- simplify(lapply(page, parseJSON), ...);
    if(!missing(handler)) handler(mydf);
    if(bind_pages){
      dfstack[[i]] <- mydf;
    }
    i <- i + 1L;
  }

  if(con_opened){
    if(verbose) message("closing connection")
    close(con)
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

  con_opened = FALSE;

  if(!is(con, "connection")){
    # Maybe handle URLs here in future.
    stop("Argument 'con' must be a connection.")
  }

  if(!isOpen(con, "w")){
    if(verbose) message("opening connection.")
    con_opened = TRUE;
    open(con, "w")
  }

  stopifnot(is.data.frame(x))
  nr <- nrow(x)
  npages <- nr %/% pagesize;
  lastpage <- nr %% pagesize;

  for(i in seq_len(npages)){
    from <- pagesize * (i-1) + 1;
    to <- pagesize * i
    if(verbose) message("Writing page ", i, ": ", pagesize, " lines.")
    stream_out_page(x[from:to, ,drop = FALSE], con = con, verbose = verbose, ...)
  }
  if(lastpage){
    from <- nr - lastpage + 1;
    if(verbose) message("Writing page ", npages + 1, ": ", lastpage, " lines.")
    stream_out_page(x[from:nr, ,drop = FALSE], con = con, verbose = verbose, ...)
  }
  if(con_opened){
    message("closing connection.")
    close(con)
  }
  invisible();
}

stream_out_page <- function(page, con, ...){
  writeLines(asJSON(page, collapse = FALSE, ...), con = con)
}