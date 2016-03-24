context("toJSON raw")

test_that("Encoding raw vector", {
  x <- list(myraw = charToRaw("bla"))
  x$mydf <- data.frame(foo=1:3)
  x$mydf$bar <- as.character.hexmode(charToRaw("bla"))
  
  y <- fromJSON(toJSON(x))
  expect_that(x$mydf$bar, is_identical_to(y$mydf$bar))
  expect_that(y$myraw, is_identical_to("Ymxh"))
});
