.onAttach <- function(lib, pkg) {
  # remove View override in newer versions of RStudio, which can handle nested
  # frames natively
  if (rstudioapi::isAvailable("0.99.324")) {
    unlockBinding("View", as.environment("package:jsonlite"))
    assign("View", get("View", "package:utils"), "package:jsonlite")
    lockBinding("View", as.environment("package:jsonlite"))
  }
}
