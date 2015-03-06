# Removes 'View' from jsonlite namespace in newer versions of RStudio, which
# handle nested frames natively; take no action if rstudioapi isn't present
.onLoad <- function(lib, pkg) {
  rstudioapi <- "rstudioapi"
  if (nchar(Sys.getenv("RSTUDIO")) && requireNamespace(rstudioapi, quietly = TRUE)) {
    isAvailable <- get("isAvailable", envir = asNamespace(rstudioapi))
    if (isAvailable("0.99.324")) {
      remove("View", pos = environment(.onLoad))
    }
  }
}
