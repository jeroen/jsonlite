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

#' @export
vec_proxy_json <- function(x) {
  UseMethod("vec_proxy_json", x)
}

#' @export
vec_proxy_json.vctrs_vctr <- function(x) {
  class(x) <- setdiff(class(x), "vctrs_vctr")
  x
}
