#' @method print json
#' @export
print.json <- function(x, ...){
  cat(x, "\n")
}

#' @method print scalar
#' @export
print.scalar <- function(x, ...){
  original <- x;
  if(is.data.frame(x)){
    row.names(x) <- "[X]"
  } else {
    names(x) <- "[X]"
  }
  class(x) <- class(x)[-1]
  print(x)
  invisible(original)
}
