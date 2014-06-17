context("toJSON Data Frame")

test_that("data frame edge cases", {
 #unname named list
  test <- data.frame(foo=1:2)
  test$bar <- list(x=123, y=123)
  test$baz <- data.frame(z=456:457)
  expect_that(toJSON(test), equals('[{"foo":1,"bar":[123],"baz":{"z":456}},{"foo":2,"bar":[123],"baz":{"z":457}}]'))
});
