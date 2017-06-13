context("toJSON R6Class")

R6.print <- function(...) {
  args = list(...);
  fields = NULL;
  to.print = list();
  if(is.null(args$fields)) {
    fields = names(get(class(self))$public_fields)
  } else {
    fields = args$fields
  }
  for(f in fields) {
    to.print[[f]] = self[[f]]
  }
  print(to.print);
}

test_that("Encoding R6 public properties", {
  ## Example R6 class:
  ##  > https://github.com/wch/R6/blob/master/tests/testthat/test-portable.R
  AC = R6::R6Class("AC",
    cloneable = F,
    public = list(
      x = 1, z = 3,
      initialize = function(x, y) {
        self$x <- self$x + x
        private$y <- y
      },
      gety = function() private$y
    ),
    private = list(y = 2)
  )
  AC$set("public","print", R6.print)
  A <- AC$new(4, 5)

  expect_equal(toJSON(A), "{\"x\":[5],\"z\":[3]}")
  expect_equal(toJSON(A, fields="x"), "{\"x\":[5]}")
})
