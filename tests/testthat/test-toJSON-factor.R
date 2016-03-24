context("toJSON Factor")

test_that("Encoding Factor Objects", {
  expect_that(fromJSON(toJSON(iris$Species)), is_identical_to(as.character(iris$Species)));
  expect_that(fromJSON(toJSON(iris$Species[1])), is_identical_to(as.character(iris$Species[1])));
  expect_that(fromJSON(toJSON(iris$Species, factor="integer")), equals(structure(unclass(iris$Species), levels=NULL)));
});
