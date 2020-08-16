context("toJSON ITime")

test_that("toJSON works for ITime objects", {
  skip_if_not_installed("data.table")
  object <- data.table::as.ITime("12:00:00")
  expect_equal(asJSON(object), "[\"12:00:00\"]")
})
