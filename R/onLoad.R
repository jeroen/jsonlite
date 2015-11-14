# Removes 'View' from jsonlite namespace in newer versions of RStudio, which
# handle nested frames natively; take no action if rstudioapi isn't present
.onLoad <- function(lib, pkg) {
  if (nchar(Sys.getenv("RSTUDIO"))) {
    remove("View", pos = environment(.onLoad))
  }
}
