loadpkg <- function(pkg){
  tryCatch(getNamespace(pkg), error = function(e) {
    stop("Package ", pkg, " not found. Please run: install.packages('httr')",
      call. = FALSE)
  })
}
