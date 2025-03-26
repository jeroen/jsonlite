test_that("Encoding AsIs", {
  expect_equal(toJSON(list(1), auto_unbox = TRUE), "[1]")
  expect_equal(toJSON(list(I(1)), auto_unbox = TRUE), "[[1]]")
  expect_equal(toJSON(I(list(1)), auto_unbox = TRUE), "[1]")

  expect_equal(toJSON(list(x = 1)), "{\"x\":[1]}")
  expect_equal(toJSON(list(x = 1), auto_unbox = TRUE), "{\"x\":1}")
  expect_equal(toJSON(list(x = I(1)), auto_unbox = TRUE), "{\"x\":[1]}")

  expect_equal(toJSON(list(x = I(list(1))), auto_unbox = TRUE), "{\"x\":[1]}")
  expect_equal(toJSON(list(x = list(I(1))), auto_unbox = TRUE), "{\"x\":[[1]]}")
})
