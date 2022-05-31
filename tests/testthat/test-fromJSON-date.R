context("fromJSON date objects")

test_that("fromJSON date objects", {

  x <- Sys.time() + c(1, 2, NA, 3)
  mydf <- data.frame(x=x)
  expect_that(fromJSON(toJSON(x, POSIXt="mongo")), is_a("POSIXct"))
  expect_that(fromJSON(toJSON(x, POSIXt="mongo")), equals(x))
  #expect_that(fromJSON(toJSON(x, POSIXt="mongo", na="string")), is_a("POSIXct"))
  expect_that(fromJSON(toJSON(x, POSIXt="mongo", na="null")), is_a("POSIXct"))

  expect_that(fromJSON(toJSON(mydf, POSIXt="mongo")), is_a("data.frame"))
  expect_that(fromJSON(toJSON(mydf, POSIXt="mongo"))$x, is_a("POSIXct"))
  #expect_that(fromJSON(toJSON(mydf, POSIXt="mongo", na="string"))$x, is_a("POSIXct"))
  expect_that(fromJSON(toJSON(mydf, POSIXt="mongo", na="null"))$x, is_a("POSIXct"))
  expect_that(fromJSON(toJSON(mydf, POSIXt="mongo"))$x, equals(x))

  xct <- as.POSIXct(x)
  xlt <- as.POSIXlt(x)

  expect_equal(xct, xlt)
  expect_true(unbox(xct[1]) == unbox(xlt[1]))
  xct3un <- unbox(xct[3])
  expect_true(is.na(xct3un) && is(xct3un,"scalar") && is(xct3un,"POSIXt"))
  xlt3un <- unbox(xlt[3])
  expect_true(is.na(xlt3un) && is(xlt3un,"scalar") && is(xlt3un,"POSIXt"))

  expect_equal(toJSON(xct,POSIXt="mongo"),toJSON(xlt,POSIXt="mongo"))
  expect_equal(toJSON(unbox(xct[1]),POSIXt="mongo"),
              toJSON(unbox(xlt[1]),POSIXt="mongo"))

});

