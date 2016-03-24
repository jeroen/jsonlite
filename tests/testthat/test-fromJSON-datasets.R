context("fromJSON datasets")

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
    expect_that(newobject, is_a("data.frame"));
    expect_that(names(object), is_identical_to(names(newobject)));
    expect_that(nrow(object), is_identical_to(nrow(newobject)))
  });
});
