test_that("Encoding Factor Objects", {
  expect_identical(fromJSON(toJSON(iris$Species)), as.character(iris$Species))
  expect_identical(fromJSON(toJSON(iris$Species[1])), as.character(iris$Species[1]))
  expect_equal(fromJSON(toJSON(iris$Species, factor = "integer")), structure(unclass(iris$Species), levels = NULL))
})
