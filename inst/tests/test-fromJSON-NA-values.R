context("fromJSON NA values")

test_that("fromJSON NA values", {
  
  objects <- list(
    numbers = c(1,2, NA, NaN, Inf, -Inf, 3.14),
    logical = c(TRUE, FALSE, NA),
    character = c("Foo", NA, "Bar"),
    integers = as.integer(1,2,3),
    num = 3.14,
    logical = FALSE,
    character = "FOO",
    integer = 21L,
    logicalNA = as.logical(NA)
  )
  
  #test all but list
  lapply(objects, function(object){
    expect_that(fromJSON(toJSON(object)), equals(object))   
  });
  
  #test all in list
  expect_that(fromJSON(toJSON(objects)), equals(objects))
});
