

# Note about numeric precision
# In the unit tests we use digits=10. Lowever values will result in problems for some datasets
test_that("fromJSON datasets", {
  objects <- Filter(is.data.frame, lapply(ls("package:datasets"), get));

  #data frames are never identical because:
  # - attributes
  # - factors, times, dates turn into strings
  # - integers turn into numeric
  lapply(objects, function(object){
    newobject <- fromJSON(toJSON(object))
    expect_s3_class(newobject, "data.frame");
    expect_identical(names(object), names(newobject));
    expect_identical(nrow(object), nrow(newobject));
  });
});
