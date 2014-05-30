toJSON <- function(...){
  unclass(minify(jsonlite::toJSON(...)))
}
