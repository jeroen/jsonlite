context("libjson Validator")

test_that("test that the validator properly deals with escaped characters", {
  
  #create random strings
  mychars <- c('a', 'b', " ", '"', "\\", "\t", "\n", "'", "/", "#", "$");
  createstring <- function(length){
    paste(mychars[ceiling(runif(length, 0, length(mychars)))], collapse="")
  }  
  
  for(i in 1:200){    
    #create some random strings to validate
    x <- createstring(i);
    expect_that(validate(toJSON(x)), is_true());
  }
  
});
