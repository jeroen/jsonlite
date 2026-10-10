context("simplifyDataFrame")

test_that("simplifyDataFrame() works", {
  source <- list(
    list(a = 11, b = 12),
    list(d = 24),
    list(a = 31, c = 33)
  )

  actual <- simplifyDataFrame(source, flatten = TRUE)

  # Check that column order is preserved as discovered in the data
  expect_equal(colnames(actual), c("a", "b", "d", "c"))

  expect_row_equals <- function(number, expected) {
    expect_equal(
      as.numeric(actual[number, ]),
      expected
    )
  }
  #                       a   b   d   c
  expect_row_equals(1, c(11, 12, NA, NA))
  expect_row_equals(2, c(NA, NA, 24, NA))
  expect_row_equals(3, c(31, NA, NA, 33))
})

test_that("transpose_list() does not change locale", {
  locale_before <- Sys.getlocale()
  transpose_list(list(a = 1), c("a"))
  locale_after <- Sys.getlocale()

  expect_equal(locale_before, locale_after)
})
