test_that("flattening", {
  x <- list(test = data.frame(foo = 1:3))
  x$test$bar <- data.frame(x = 5:3, y = 7:9)
  expect_equal(x, fromJSON(toJSON(x), flatten = FALSE))
  expect_equal(names(fromJSON(toJSON(x), flatten = TRUE)$test), c("foo", "bar.x", "bar.y"))
})
