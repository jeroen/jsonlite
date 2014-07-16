context("fromJSON Matrix")

# Note about numeric precision
# In the unit tests we use digits=10. Lowever values will result in problems for some datasets
test_that("fromJSON Matrix", {
  objects <- list(
    matrix(1),
    matrix(1:2),
    matrix(1:2, nrow=1),
    matrix(round(pi,2)),
    matrix(c(1,NA,2,NA), 2),
    volcano,
    matrix(NA)    
  );
  
  lapply(objects, function(object){
    newobject <- fromJSON(toJSON(object));
    expect_that(newobject, is_a("matrix"));
    expect_that(object, equals(newobject));
  });
  
  expect_that(fromJSON(toJSON(objects)), equals(objects));  
});

test_that("fromJSON Matrix with simplifyMatrix=FALSE", {
  expect_that(fromJSON(toJSON(matrix(1)), simplifyMatrix=FALSE), equals(list(1)));
  expect_that(fromJSON(toJSON(matrix(1)), simplifyVector=FALSE), equals(list(list((1)))));
  expect_that(fromJSON(toJSON(matrix(NA)), simplifyMatrix=FALSE), equals(list(NA)));
  expect_that(fromJSON(toJSON(matrix(NA)), simplifyVector=FALSE), equals(list(list((NULL)))));
});


test_that("fromJSON Matrix datasets", {
  objects <- Filter(is.matrix, lapply(ls("package:datasets"), get));
  
  lapply(objects, function(object){
    class(object) <- "matrix";
    newobject <- fromJSON(toJSON(object, digits=4))
    expect_that(newobject, is_a("matrix"));
    expect_that(dim(newobject), equals(dim(object)));
    attributes(newobject) <- attributes(object);
    expect_that(newobject, equals(round(object,4)));
  });
});
