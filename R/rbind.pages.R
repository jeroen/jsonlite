rbind.pages <- function(dfs){
  stopifnot(is.list(dfs))
  stopifnot(all(vapply(dfs, is.data.frame, logical(1))))
  
  # Extract data frame column names
  dfdf <- lapply(dfs, vapply, is.data.frame, logical(1))
  dfnames <- unique(names(which(unlist(dfdf))))
  subdfs <- lapply(dfnames, function(colname){
    combine_pages(lapply(dfs, `[[`, colname))
  })
  names(subdfs) <- dfnames
  
  # Remove data frame columns
  dfs <- lapply(dfs, function(df){
    df[!vapply(df, is.data.frame, logical(1))]
  })
  
  # Bind rows
  outdf <- plyr::rbind.fill(dfs)
  
  # Combine wih sub dataframes
  out <- c(outdf, subdfs)
  class(out) <- "data.frame"
  row.names(out) <- row.names(outdf)
  
  #out
  out  
}
