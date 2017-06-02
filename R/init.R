.onAttach <- function(lib, pkg) {
  # remove View override in newer versions of RStudio, which can handle nested
  # frames natively; take no action if rstudioapi isn't present
  rstudioapi <- "rstudioapi"
  if (requireNamespace(rstudioapi, quietly = TRUE)) {
    isAvailable <- get("isAvailable", envir = asNamespace(rstudioapi))
    if (isAvailable("0.99.324")) {
      assign("View", get("View", "package:utils"), "package:jsonlite")
    }
  }
}
