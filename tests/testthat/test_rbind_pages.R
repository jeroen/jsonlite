context("rbind_pages")

options(stringsAsFactors=FALSE)

test_that("handles named list argument", {
  x <- data.frame(foo = c(1:2))
  x$bar <- data.frame(name = c("jeroen", "eli"),
                     age  = c(28, 24))
  x  <- rep(list(x), 4)
  xn <- setNames(x, letters[1:4])

  expect_equal(rbind_pages(xn), rbind_pages(x))
  expect_false(all(is.na(rbind_pages(xn)$bar)))
})

test_that("handles empty input", {
  x <- rbind_pages(list())
  expect_is(x, "data.frame")
  expect_identical(dim(x), c(0L, 0L))
})

test_that("handles regular data frames", {
  x <- data.frame(a=1:2, b=3:4)
  y <- data.frame(c=5:6, d=7:8)

  xy <- rbind_pages(list(x, y))

  expect_equal(xy$a, c(1, 2, NA, NA))
  expect_equal(xy$b, c(3, 4, NA, NA))
  expect_equal(xy$c, c(NA, NA, 5, 6))
  expect_equal(xy$d, c(NA, NA, 7, 8))
})

test_that("rejects non-NULL, non-data frame inputs", {
  x <- 1:4
  y <- data.frame(a=1:4)
  expect_error(rbind_pages(list(x, y)))
})

test_that("handles nested data frames", {
  # need to construct this carefully to avoid data.frame() unnesting inputs
  dfx <- data.frame(a=1:2)
  dfx$df1 <- data.frame(b=3:4)
  dfx$df1$df2 <- data.frame(c=5:6, d=7:8)

  out <- rbind_pages(list(dfx, dfx))

  expect_is(out, "data.frame")
  expect_is(out$df1, "data.frame")
  expect_is(out$df1$df2, "data.frame")
  expect_identical(names(out$df1$df2), c("c", "d"))
  expect_identical(out$df1$df2$c, c(5L, 6L, 5L, 6L))
  expect_identical(out$df1$df2$d, c(7L, 8L, 7L, 8L))
})
