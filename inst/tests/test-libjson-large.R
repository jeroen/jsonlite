context("libjson Large strings")

test_that("escaping and parsing of special characters", {
  
  #create random strings
  mychars <- c('a', 'b', " ", '"', "\\", "\t", "\n", "'", "/", "#", "$");
  createstring <- function(length){
    paste(mychars[ceiling(runif(length, 0, length(mychars)))], collapse="")
  }  

  #try some very long strings
  for(i in 1:10){
    zz <- list(foo=createstring(1e5))
    expect_that(zz, equals(fromJSON(toJSON(zz))));
  }
  
});
