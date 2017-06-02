context("scalar")

test_that("Creating scalars", {
  expect_is(unbox(1), c("scalar", "numeric"))
  expect_is(unbox(1L), c("scalar", "integer"))
  expect_is(unbox("a"), c("scalar", "character"))
  expect_is(unbox(TRUE), c("scalar", "logical"))
  expect_is(unbox(iris[1,]), c("scalar", "data.frame"))
  expect_identical(unbox(NULL), NULL)
  expect_error(unbox(c(1, 2)))
  expect_error(unbox(iris))
})

test_that("Modifying scalars", {
  x <- unbox(1)
  expect_is(x, c("scalar", "numeric"))
  expect_equal(as.numeric(x), 1)

  x[1] <- 0
  expect_is(x, c("scalar", "numeric"))
  expect_equal(as.numeric(x), 0)
  expect_error(x[2] <- 1)

  x <- unbox(iris[1,])
  expect_is(x, c("scalar", "data.frame"))
  expect_equal(unclass(x), unclass(iris[1,]))
  expect_equal({
    x$Species <- 0
    x$Species
  }, 0)
  expect_equal({
    x$New <- 1
    x$New
  }, 1)
  expect_error(x[2, ] <- iris[2, ])
})
