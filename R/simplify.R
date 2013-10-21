simplify <- function(x){
  if(is.list(x) && is.null(names(x)) && isTRUE(all(sapply(x, function(el){
    isTRUE(is.atomic(el) && length(el) <= 1);
  })))){
    return(null2na(x));
  }
  
  #recursion
  if(is.list(x)){
    for(i in seq_along(x)){
      x[[i]] <- Recall(x[[i]]);
    }
  }
     
  return(x);
}
