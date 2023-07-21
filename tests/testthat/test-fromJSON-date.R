

test_that("fromJSON date objects", {

  x <- Sys.time() + c(1, 2, NA, 3)
  mydf <- data.frame(x=x)
  expect_s3_class(fromJSON(toJSON(x, POSIXt="mongo")), "POSIXct");
  expect_equal(fromJSON(toJSON(x, POSIXt="mongo")), x);
  #expect_s3_class(fromJSON(toJSON(x, POSIXt="mongo", na="string")), "POSIXct");
  expect_s3_class(fromJSON(toJSON(x, POSIXt="mongo", na="null")), "POSIXct");

  expect_s3_class(fromJSON(toJSON(mydf, POSIXt="mongo")), "data.frame");
  expect_s3_class(fromJSON(toJSON(mydf, POSIXt="mongo"))$x, "POSIXct");
  #expect_s3_class(fromJSON(toJSON(mydf, POSIXt="mongo", na="string"))$x, "POSIXct");
  expect_s3_class(fromJSON(toJSON(mydf, POSIXt="mongo", na="null"))$x, "POSIXct");
  expect_equal(fromJSON(toJSON(mydf, POSIXt="mongo"))$x, x);

  xct <- as.POSIXct(x)
  xlt <- as.POSIXlt(x)

  expect_equal(xct, xlt)
  expect_true(unbox(xct[1]) == unbox(xlt[1]))
  xct3un <- unbox(xct[3])
  expect_true(is.na(xct3un) && inherits(xct3un,"scalar") &&
              inherits(xct3un,"POSIXt"))
  xlt3un <- unbox(xlt[3])
  expect_true(is.na(xlt3un) && inherits(xlt3un,"scalar") &&
              inherits(xlt3un,"POSIXt"))

  expect_equal(toJSON(xct,POSIXt="mongo"),toJSON(xlt,POSIXt="mongo"))
  expect_equal(toJSON(unbox(xct[1]),POSIXt="mongo"),
              toJSON(unbox(xlt[1]),POSIXt="mongo"))

});

