null2na <- function(x) {
  if (!length(x)) {
    return(vector())
  }

  #Start parsing missing values
  x2 <- x
  looks_like_character_vector = FALSE
  for(i in seq_along(x2)){
    if(is.character(x2[[i]])){
      x2[[i]] <- switch(x2[[i]],
        "NA" = NA,
        "NaN" = NaN,
        "Inf" = Inf,
        "-Inf" = -Inf,
        {looks_like_character_vector=TRUE; break}
      )
    }
  }

  # Set x
  if(!looks_like_character_vector){
    x <- x2
  }

  # Convert NULL to NA
  x[vapply(x, is.null, logical(1))] <- NA

  # Unlist only if set
  return(unlist(x, recursive = FALSE, use.names = FALSE))
}
