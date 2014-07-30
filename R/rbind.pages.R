rbind.pages <- function(dfs){
  stopifnot(is.list(dfs))
  stopifnot(all(vapply(dfs, function(x){is.null(x) || is.data.frame(x)}, logical(1))))
  
  # Extract data frame column names
  dfdf <- lapply(dfs, vapply, is.data.frame, logical(1))
  dfnames <- unique(names(which(unlist(dfdf))))
  
  # No sub data frames
  if(!length(dfnames)){
    return(plyr::rbind.fill(dfs))
  }
  
  # Extract the nested data frames
  subdfs <- lapply(dfnames, function(colname){
    rbind.pages(lapply(dfs, function(df) {
      if(!is.null(df[[colname]])) 
        df[[colname]] 
      else 
        as.data.frame(matrix(nrow=nrow(df), ncol=0))
    }))
  })
  
  # Remove data frame columns
  dfs <- lapply(dfs, function(df){
    df[vapply(df, is.data.frame, logical(1))] <- rep(NA, nrow(df));
    df
  })
  
  # Bind rows
  outdf <- plyr::rbind.fill(dfs)
  
  # Combine wih sub dataframes
  for(i in seq_along(subdfs)){
    outdf[[dfnames[i]]] <- subdfs[[i]]
  }

  #out
  outdf
}
