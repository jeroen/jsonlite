context("toJSON ITime")

test_that("toJSON works for ITime objects", {
  skip_if_not_installed("data.table")
  object <- structure(43200L, class = "ITime")
  # need to load data.table's namespace
  # otherwise the S3 method as.character.ITime() won't be registered
  requireNamespace('data.table') 
  expect_equal(asJSON(object), "[\"12:00:00\"]")
})
