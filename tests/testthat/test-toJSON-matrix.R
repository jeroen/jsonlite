test_that("Encoding a Matrix", {
  expect_equal(toJSON(matrix(1)), "[[1]]")
  expect_equal(toJSON(matrix(pi), digits = 5), "[[3.14159]]")
  expect_equal(toJSON(matrix(1:2)), "[[1],[2]]")
  expect_equal(toJSON(matrix(1:2, nrow = 1)), "[[1,2]]")
  expect_equal(toJSON(matrix(state.x77[1, 1, drop = FALSE])), "[[3615]]")
})
