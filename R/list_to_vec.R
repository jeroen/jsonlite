list_to_vec <- function(x) {
  return(unlist(null_to_na(x), recursive = FALSE, use.names = FALSE))
}
