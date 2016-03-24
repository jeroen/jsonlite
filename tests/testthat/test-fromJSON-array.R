context("fromJSON Array")

test_that("fromJSON Array, row major", {

  # test high dimensional arrays
  lapply(2:5, function(n){
    object <- array(1:prod(n), dim=1:n)
    newobject <- fromJSON(toJSON(object));
    expect_that(object, equals(newobject));
  });
  
  # adding some flat dimensions
  lapply(1:5, function(n){
    object <- array(1:prod(n), dim=c(1:n, 1))
    newobject <- fromJSON(toJSON(object));
    expect_that(object, equals(newobject));
  });  
});

test_that("fromJSON Array, column major", {
  
  # test high dimensional arrays
  lapply(2:5, function(n){
    object <- array(1:prod(n), dim=1:n)
    newobject <- fromJSON(toJSON(object, matrix="columnmajor"), columnmajor=TRUE);
    expect_that(object, equals(newobject));
  });
  
  # adding some flat dimensions
  lapply(1:5, function(n){
    object <- array(1:prod(n), dim=c(1:n, 1))
    newobject <- fromJSON(toJSON(object, matrix="columnmajor"), columnmajor=TRUE);
    expect_that(object, equals(newobject));
  });  
});


test_that("fromJSON Array, character strings", {
  
  # test high dimensional arrays
  lapply(2:5, function(n){
    object <- array(paste("cell", 1:prod(n)), dim=1:n)
    newobject <- fromJSON(toJSON(object, matrix="columnmajor"), columnmajor=TRUE);
    expect_that(object, equals(newobject));
  });
  
  # adding some flat dimensions
  lapply(1:5, function(n){
    object <- array(paste("cell", 1:prod(n)), dim=c(1:n, 1))
    newobject <- fromJSON(toJSON(object, matrix="columnmajor"), columnmajor=TRUE);
    expect_that(object, equals(newobject));
  });  
});