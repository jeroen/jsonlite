#' Prettify JSON
#' 
#' Add proper whitespace and indentation to a JSON string.
#' 
#' @param txt JSON string
#' @export
#' @family prettify
#' @examples myjson <- toJSON(cars, pretty=FALSE)
#' myprettyjson <- prettify(myjson)
#' cat(myprettyjson)
prettify <- function(txt) {
  txt <- paste(as.character(txt), collapse = "\n")
  enc <- mapEncoding(Encoding(txt))
  .Call("R_jsonPrettyPrint", txt, enc)
} 
