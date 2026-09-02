test_that("escaping and parsing of special characters", {
  #create random strings
  mychars <- c('a', 'b', " ", '"', "\\", "\t", "\n", "'", "/", "#", "$")
  createstring <- function(length) {
    paste(mychars[ceiling(runif(length, 0, length(mychars)))], collapse = "")
  }

  #try some very long strings
  for (i in 1:10) {
    zz <- list(foo = createstring(1e5))
    expect_equal(zz, fromJSON(toJSON(zz)))
  }
})

test_that("integer overflow handling", {
  # LLONG_MAX
  expect_equal(fromJSON("9223372036854775807", bigint_as_char = TRUE), "9223372036854775807")
  # LLONG_MIN
  expect_equal(fromJSON("-9223372036854775808", bigint_as_char = TRUE), "-9223372036854775808")

  # Overflow cases should fall back to double (numeric in R)
  # LLONG_MAX + 1
  expect_type(fromJSON("9223372036854775808", bigint_as_char = TRUE), "double")
  # LLONG_MIN - 1
  expect_type(fromJSON("-9223372036854775809", bigint_as_char = TRUE), "double")

  # Extreme overflow
  expect_type(fromJSON("9223372036854775833333388", bigint_as_char = TRUE), "double")
})

test_that("invalid number formats", {
  expect_error(fromJSON("-+123"), "lexical error")
  expect_error(fromJSON("+-123"), "lexical error")
  # RFC 8259, Section 6: leading '+' is not valid
  expect_error(fromJSON("+123"), "lexical error")
})
