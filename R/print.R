#' @method print json
#' @export
print.json <- function(x, ...){
  cat(x, "\n")
}

#' @method print scalar
#' @export
print.scalar <- function(x, ...){
  original <- x;
  class(x) <- class(x)[-1]
  if(is.data.frame(x)){
    row.names(x) <- "[x]"
    print(x)
  } else {
    cat("[x] ", x, "\n", sep="")
  }
  invisible(original)
}
