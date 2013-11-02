context("toJSON Numeric")

test_that("Encoding Numbers", {
  expect_that(toJSON(35), equals("[ 35 ]"));
  expect_that(toJSON(35L), equals("[ 35 ]"));
  expect_that(toJSON(c(35, pi), digits=5), equals("[ 35, 3.14159 ]"));  
  expect_that(toJSON(pi, digits=0), equals("[ 3 ]")); 
  expect_that(toJSON(pi, digits=2), equals("[ 3.14 ]")); 
  expect_that(toJSON(pi, digits=20), equals("[ 3.141592653589793116 ]"));
  expect_that(toJSON(c(pi, NA), NA_as_string=TRUE, digits=5), equals("[ 3.14159, \"NA\" ]"));
  expect_that(toJSON(c(pi, NA), NA_as_string=FALSE, digits=5), equals("[ 3.14159, null ]"));
});

test_that("Encoding Numbers in Data Frame", {
  expect_that(toJSON(data.frame(foo=35)), equals("[ { \"foo\" : 35 } ]"));
  expect_that(toJSON(data.frame(foo=35L)), equals("[ { \"foo\" : 35 } ]"));
  expect_that(toJSON(data.frame(foo=c(35, pi)), digits=5), equals("[ { \"foo\" : 35 },{ \"foo\" : 3.14159 } ]"));  
  expect_that(toJSON(data.frame(foo=pi), digits=0), equals("[ { \"foo\" : 3 } ]")); 
  expect_that(toJSON(data.frame(foo=pi), digits=2), equals("[ { \"foo\" : 3.14 } ]")); 
  expect_that(toJSON(data.frame(foo=pi), digits=20), equals("[ { \"foo\" : 3.141592653589793116 } ]"));
  expect_that(toJSON(data.frame(foo=c(pi, NA)), drop.na=TRUE, digits=5), equals("[ { \"foo\" : 3.14159 },{} ]"));              
  expect_that(toJSON(data.frame(foo=c(pi, NA)), drop.na=FALSE, NA_as_string=TRUE, digits=5), equals( "[ { \"foo\" : 3.14159 },{ \"foo\" : \"NA\" } ]"));
  expect_that(toJSON(data.frame(foo=c(pi, NA)), drop.na=FALSE, NA_as_string=FALSE, digits=5), equals("[ { \"foo\" : 3.14159 },{ \"foo\" : null } ]"));
});
