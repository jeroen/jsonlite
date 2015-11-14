# Removes 'View' from jsonlite namespace in RStudio, which handles nested
# frames natively.
.onLoad <- function(lib, pkg) {
  if (nchar(Sys.getenv("RSTUDIO"))) {
    remove("View", pos = environment(.onLoad))
  }
}
