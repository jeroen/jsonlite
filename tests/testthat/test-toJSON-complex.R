context("toJSON Complex")

test_that("Encoding Complex", {
  expect_that(toJSON(complex(real=2, imaginary=2)), equals("[\"2+2i\"]"));
  expect_that(toJSON(complex(real=NA, imaginary=2)), equals("[\"NA\"]"));  
  expect_that(toJSON(complex(real=1, imaginary=NA)), equals("[\"NA\"]"));   
  expect_that(toJSON(complex(real=NA, imaginary=2), na="null"), equals("[null]")); 
});

test_that("Encoding Complex in Data Frame", {
  expect_that(toJSON(data.frame(foo=complex(real=1, imaginary=2))), equals("[{\"foo\":\"1+2i\"}]"));
  expect_that(toJSON(data.frame(foo=complex(real=NA, imaginary=2))), equals("[{}]"));
  expect_that(toJSON(data.frame(foo=complex(real=NA, imaginary=2)), na="string"), equals("[{\"foo\":\"NA\"}]"));
  expect_that(toJSON(data.frame(foo=complex(real=NA, imaginary=2)), na="null"), equals("[{\"foo\":null}]"));
});

test_that("Encoding Complex as list", {
  x <- complex(real=c(1,2,NA), imaginary=3:1);
  expect_that(toJSON(x), equals("[\"1+3i\",\"2+2i\",\"NA\"]"));
  expect_that(toJSON(x, complex="list"), equals("{\"real\":[1,2,\"NA\"],\"imaginary\":[3,2,1]}"));
  expect_that(toJSON(data.frame(foo=x), complex="list"), equals("[{\"foo\":{\"real\":1,\"imaginary\":3}},{\"foo\":{\"real\":2,\"imaginary\":2}},{\"foo\":{\"imaginary\":1}}]"));
  expect_that(toJSON(data.frame(foo=x), complex="list", na="string"), equals("[{\"foo\":{\"real\":1,\"imaginary\":3}},{\"foo\":{\"real\":2,\"imaginary\":2}},{\"foo\":{\"real\":\"NA\",\"imaginary\":1}}]"));
  expect_that(toJSON(data.frame(foo=x), complex="list", dataframe="columns"), equals("{\"foo\":{\"real\":[1,2,\"NA\"],\"imaginary\":[3,2,1]}}"))
});
