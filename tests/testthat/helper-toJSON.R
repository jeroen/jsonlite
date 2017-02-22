toJSON <- function(...){
  unclass(jsonlite::toJSON(...))
}

toJSON2 <- function(x) {
  toJSON(x, keep_vec_names = TRUE, auto_unbox = TRUE)
}

toJSON3 <- function(x) {
  toJSON(x, keep_vec_names = TRUE, auto_unbox = TRUE, dataframe = "columns", rownames = FALSE)
}
