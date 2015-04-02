apply_by_pages <- function(x, FUN, pagesize, verbose, ...){
  stopifnot(is.data.frame(x))
  nr <- nrow(x)
  npages <- nr %/% pagesize;
  lastpage <- nr %% pagesize;

  for(i in seq_len(npages)){
    from <- pagesize * (i-1) + 1;
    to <- pagesize * i
    FUN(x[from:to, ,drop = FALSE], ...)
    if(verbose) cat("\rProcessed", i * pagesize, "rows...")
  }

  if(lastpage){
    from <- nr - lastpage + 1;
    FUN(x[from:nr, ,drop = FALSE], ...)
  }
  if(verbose) cat("\rComplete! Processed total of", nr, "rows.\n")
  invisible();
}

#this is another slightly slower implementation
apply_by_pages2 <- function(x, FUN, pagesize, verbose, ...){
  x2 <- split(x, seq_len(nrow(x)) %/% pagesize)
  for(page in x2){
    if(verbose) message("Writing ", nrow(page), " lines (", ").")
    FUN(page)
  }
  invisible()
}
