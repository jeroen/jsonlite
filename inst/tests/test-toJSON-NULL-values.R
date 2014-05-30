context("toJSON NULL values")

test_that("Test NULL values", {
  x <- NULL
  y <- list(a=NULL, b=NA)
  z <- list(a=1, b=character(0))

  expect_that(validate(toJSON(x)), is_true())
  expect_that(toJSON(x), equals("{}"))
  expect_that(fromJSON(toJSON(x)), equals(list()))

  expect_that(validate(toJSON(y)), is_true())
  expect_that(toJSON(y), equals("{\"a\":{},\"b\":[null]}"))
  expect_that(fromJSON(toJSON(y)), equals(list(a=list(), b=NA)))

  expect_that(validate(toJSON(z)), is_true())
  expect_that(toJSON(z), equals("{\"a\":[1],\"b\":[]}"))
  expect_that(fromJSON(toJSON(z)), equals(list(a=1, b=list())))
});
