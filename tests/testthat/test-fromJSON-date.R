context("fromJSON date objects")

test_that("fromJSON date objects", {
  
  x <- Sys.time() + c(1, 2, NA, 3)
  mydf <- data.frame(x=x)
  expect_that(fromJSON(toJSON(x, POSIXt="mongo")), is_a("POSIXct")) 
  expect_that(fromJSON(toJSON(x, POSIXt="mongo")), equals(x))
  expect_that(fromJSON(toJSON(x, POSIXt="mongo", na="string")), is_a("POSIXct")) 
  expect_that(fromJSON(toJSON(x, POSIXt="mongo", na="null")), is_a("POSIXct"))  
  
  expect_that(fromJSON(toJSON(mydf, POSIXt="mongo")), is_a("data.frame"))
  expect_that(fromJSON(toJSON(mydf, POSIXt="mongo"))$x, is_a("POSIXct"))
  expect_that(fromJSON(toJSON(mydf, POSIXt="mongo", na="string"))$x, is_a("POSIXct"))
  expect_that(fromJSON(toJSON(mydf, POSIXt="mongo", na="null"))$x, is_a("POSIXct"))  
  expect_that(fromJSON(toJSON(mydf, POSIXt="mongo"))$x, equals(x))

});
