context("rbind_pages")

options(stringsAsFactors=FALSE)

test_that("handles named list argument", {
  x <- data.frame(foo = c(1:2))
  x$bar = data.frame(name = c("jeroen", "eli"),
                     age  = c(28, 24))
  x  <- rep(list(x), 4)
  xn <- setNames(x, letters[1:4])

  expect_equal(rbind_pages(xn), rbind_pages(x))
  expect_false(all(is.na(rbind_pages(xn)$bar)))
})





