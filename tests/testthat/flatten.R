context("flatten")

test_that("flattening", {
  x <- list(test = data.frame(foo=1:3))
  x$test$bar <- data.frame(x=5:3, y=7:9)
  expect_that(x, equals(fromJSON(toJSON(x), flatten = FALSE)));
  expect_that(names(fromJSON(toJSON(x), flatten = TRUE)$test), equals(c("foo", "bar.x", "bar.y")))
});

