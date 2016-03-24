context("toJSON Matrix")

test_that("Encoding a Matrix", {
  expect_that(toJSON(matrix(1)), equals("[[1]]"));
  expect_that(toJSON(matrix(pi), digits=5), equals("[[3.14159]]"));
  expect_that(toJSON(matrix(1:2)), equals("[[1],[2]]"));  
  expect_that(toJSON(matrix(1:2, nrow=1)), equals("[[1,2]]")); 
  expect_that(toJSON(matrix(state.x77[1,1, drop=FALSE])), equals("[[3615]]"));
});
