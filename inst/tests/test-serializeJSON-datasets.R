#test serializeJSON 

context("Serializing Datasets")

# Note about numeric precision
# In the unit tests we use digits=10. Lowever values will result in problems for some datasets
test_that("Serializing datasets", {
  library(datasets);
  lapply(as.list(ls("package:datasets")), function(x){
    mycall <- call("expect_that", 
      call("unserializeJSON", call("serializeJSON", as.name(x), digits=10)),
      call("equals", as.name(x))
    );
    eval(mycall)
  });
});


