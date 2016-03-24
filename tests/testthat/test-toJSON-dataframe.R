context("toJSON Data Frame")

test_that("data frame edge cases", {
 #unname named list
  test <- data.frame(foo=1:2)
  test$bar <- list(x=123, y=123)
  test$baz <- data.frame(z=456:457)
  expect_that(toJSON(test), equals('[{"foo":1,"bar":[123],"baz":{"z":456}},{"foo":2,"bar":[123],"baz":{"z":457}}]'))
});

test_that("Nested structures", {
  
  mydata <- data.frame(row.names=1:2)
  mydata$d <- list(
    data.frame(a1=1:2, a2=3:4, a3=5:6, a4=7:8),
    data.frame(a1=11:12, a2=13:14, a3=15:16, a4=17:18)
  )
  mydata$m <- list(
    matrix(1:6, nrow=2, ncol=3),
    matrix(6:1, nrow=2, ncol=3)
  )
  
  expect_that(fromJSON(toJSON(mydata)), equals(mydata));
});
