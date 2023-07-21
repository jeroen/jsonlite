

test_that("fromJSON NA values", {

  objects <- list(
    numbers = c(1,2, NA, NaN, Inf, -Inf, 3.14),
    logical = c(TRUE, FALSE, NA),
    integers = as.integer(1,2,3),
    num = 3.14,
    bool = FALSE,
    character = c("FOO","NA", NA, "NaN"),
    integer = 21L,
    boolNA = as.logical(NA),
    df = data.frame(foo=c(1,NA))
  )

  #test all but list
  lapply(objects, function(object){
    expect_equal(fromJSON(toJSON(object)), object);
  });

  #test all in list
  expect_equal(fromJSON(toJSON(objects)), objects);
});
