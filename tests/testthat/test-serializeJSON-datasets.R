#test serializeJSON



# Note about numeric precision
# In the unit tests we use digits=10. Lowever values will result in problems for some datasets
test_that("Serializing datasets", {
  library(datasets);
  lapply(as.list(ls("package:datasets")), function(x){
    mycall <- call("expect_equal",
      call("unserializeJSON", call("serializeJSON", as.name(x), digits=10)),
      as.name(x)
    );
    eval(mycall)
  });
});


