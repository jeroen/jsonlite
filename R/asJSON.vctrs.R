setMethod("asJSON", "vctrs_vctr", function(x, ...) {
  tryCatch(
    {
      asJSON(vec_proxy_json(x), ...)
    },
    error = function(cond) {
      selectMethod(asJSON, "ANY")(x)
    }
  )
})

#' JSON conversion proxy
#' 
#' vec_proxy_json method returns proxy objects, i.e. an atomic vector or a list of atomic vectors,
#' able to be converted to JSON using the jsonlite package. This is a generic S3 method, that has
#' to be implemented for subclasses requesting particualar JSON conversion. A default implementation
#' is provided for `vctrs_vctr` class.
#' 
#' @param x object instance of class `vctrs_vctr` to be converted to JSON
#' 
#' @return an atomic vector or a list of atomic vectors.
#' @export
vec_proxy_json <- function(x) {
  UseMethod("vec_proxy_json", x)
}

#' @export
vec_proxy_json.vctrs_vctr <- function(x) {
  class(x) <- setdiff(class(x), "vctrs_vctr")
  x
}
