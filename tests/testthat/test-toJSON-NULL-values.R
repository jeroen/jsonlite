context("toJSON NULL values")

test_that("Test NULL values", {
  namedlist <- structure(list(), .Names = character(0));
  x <- NULL
  y <- list(a=NULL, b=NA)
  z <- list(a=1, b=character(0))

  expect_that(validate(toJSON(x)), is_true())
  expect_that(fromJSON(toJSON(x)), equals(namedlist))
  expect_that(toJSON(x), equals("{}"))
  expect_that(toJSON(x, null="list"), equals("{}"))

  expect_that(validate(toJSON(y)), is_true())
  expect_that(toJSON(y, null="list"), equals("{\"a\":{},\"b\":[null]}"))
  expect_that(toJSON(y, null="null"), equals("{\"a\":null,\"b\":[null]}"))
  expect_that(fromJSON(toJSON(y, null="null")), equals(y))
  expect_that(fromJSON(toJSON(y, null="list")), equals(list(a=namedlist, b=NA)))

  expect_that(validate(toJSON(z)), is_true())
  expect_that(toJSON(z), equals("{\"a\":[1],\"b\":[]}"))
  expect_that(fromJSON(toJSON(z)), equals(list(a=1, b=list())))
});
