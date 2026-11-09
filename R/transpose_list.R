#' @useDynLib jsonlite C_transpose_list
transpose_list <- function(x, names) {
  # Sort names before entering C, allowing for a binary search
  LC_COLLATE <- "LC_COLLATE"
  collate_before <- Sys.getlocale(LC_COLLATE)
  on.exit(Sys.setlocale(LC_COLLATE, collate_before))
  Sys.setlocale(LC_COLLATE, "C")
  sorted_names <- sort(names)

  transposed <- .Call(C_transpose_list, x, sorted_names)
  transposed[match(names, sorted_names)]
}
