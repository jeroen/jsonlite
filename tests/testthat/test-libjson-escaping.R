context("libjson Escaping")

test_that("escaping and parsing of special characters", {

  #create random strings
  mychars <- c('a', 'b', " ", '"', "\\", "\t", "\n", "'", "/", "#", "$");
  createstring <- function(length){
    paste(mychars[ceiling(runif(length, 0, length(mychars)))], collapse="")
  }

  #generate 1000 random strings
  for(i in 1:200){
    x <- createstring(i);
    expect_that(x, equals(fromJSON(toJSON(x))));
    expect_that(x, equals(fromJSON(toJSON(x, pretty=TRUE))));

    y <- setNames(list(123), x)
    expect_that(x, equals(fromJSON(toJSON(x, pretty=TRUE))));
  }

});

test_that("escape solidus", {
  expect_equal(toJSON("foo/bar/baz"), '["foo/bar/baz"]')
  expect_equal(toJSON('<script>evil()</script>'), '["<script>evil()<\\/script>"]')
  expect_equal(toJSON('/', auto_unbox = TRUE), '"/"')
  expect_equal(toJSON('</', auto_unbox = TRUE), '"<\\/"')
})

