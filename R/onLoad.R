# Removes 'View' from jsonlite namespace in RStudio, which handles nested
# frames natively.
.onLoad <- function(lib, pkg) {
  if (nchar(Sys.getenv("RSTUDIO")) && ("package:utils" %in% search())) {
    try(assign("View", get("View", "package:utils"), pos = environment(.onLoad)))
  }
}
