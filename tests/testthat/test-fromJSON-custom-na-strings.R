context("fromJSON custom NA strings")

test_that("fromJSON custom NA strings", {

  mixed = c("FOO","NA", NA, "NaN")
  single_na = c("NA")
  only_na = c("NA", "NaN", "Inf", "-Inf")
  mixed_na = c("NA", "Inf", ".")
  mixed_text_and_real_na = c(NA, Inf, "NA", ".")

  #test old behavior
  expect_that(fromJSON(toJSON(mixed)), equals(mixed))
  expect_that(fromJSON(toJSON(single_na)), equals(as.logical(NA)))
  expect_that(fromJSON(toJSON(only_na)),
              equals(c(as.logical(NA), as.double(NaN), as.double(Inf), as.double(-Inf))))
  expect_that(fromJSON(toJSON(mixed_na)), equals(mixed_na))
  expect_that(fromJSON(toJSON(mixed_text_and_real_na)),
              equals(c(as.character(NA), "Inf", "NA", ".")))

  #test new behavior
  expect_that(fromJSON(toJSON(mixed), naStrings = ""), equals(mixed))
  expect_that(fromJSON(toJSON(single_na), naStrings = ""), equals(single_na))
  expect_that(fromJSON(toJSON(single_na), naStrings = NULL), equals(single_na))
  expect_that(fromJSON(toJSON(only_na), naStrings = ""), equals(only_na))
  expect_that(fromJSON(toJSON(only_na), naStrings = NULL), equals(only_na))
  expect_that(fromJSON(toJSON(only_na), naStrings = c("NA", "NaN", "Inf")), equals(only_na))
  expect_that(fromJSON(toJSON(only_na), naStrings = c("NA", "NaN", "Inf", "-Inf")),
              equals(c(as.logical(NA), as.double(NaN), as.double(Inf), as.double(-Inf))))
  expect_that(fromJSON(toJSON(mixed_na), naStrings = c("NA", ".", "Inf")),
              equals(c(as.logical(NA), as.double(Inf), as.logical(NA))))
  expect_that(fromJSON(toJSON(mixed_text_and_real_na), naStrings = c("NA", ".", "Inf")),
              equals(c(as.logical(NA), as.double(Inf), rep(as.logical(NA), 2))))
})
