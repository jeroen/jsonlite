#test serializeJSON 

context("Serializing Functions")

# Note about numeric precision
# In the unit tests we use digits=10. Lowever values will result in problems for some datasets
test_that("Serializing Functions", {
  
  options(keep.source=FALSE);
  
  objects <- list(
    function(x = 0) { x + 1 },
    function(x) { x + 1 },
    function(x, ...) { x + 1},
    lm
  );
    
  
  #test all but list
  lapply(objects, function(object){
    expect_that(unserializeJSON(serializeJSON(object)), equals(object))   
  });
  
  #test all in list
  expect_that(unserializeJSON(serializeJSON(objects)), equals(objects))
});
