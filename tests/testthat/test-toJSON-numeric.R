

test_that("Encoding Numbers", {
  expect_equal(toJSON(35), "[35]");
  expect_equal(toJSON(35L), "[35]");
  expect_equal(toJSON(c(35, pi), digits=5), "[35,3.14159]");
  expect_equal(toJSON(pi, digits=0), "[3]");
  expect_equal(toJSON(pi, digits=2), "[3.14]");
  expect_equal(toJSON(pi, digits=10), "[3.1415926536]");
  expect_equal(toJSON(c(pi, NA), na="string", digits=5), "[3.14159,\"NA\"]");
  expect_equal(toJSON(c(pi, NA), na="null", digits=5), "[3.14159,null]");
  expect_equal(toJSON(c(pi, NA), na="null", digits=5), "[3.14159,null]");
  expect_equal(toJSON(c(1478002353.51369, -521997646.486311) * 1000, digits = 0), "[1478002353514,-521997646486]");
  expect_equal(toJSON(list(a=c(0.1)), digits = NA), '{"a":[0.1]}');
});

test_that("Encoding Numbers in Data Frame", {
  expect_equal(toJSON(data.frame(foo=35)), "[{\"foo\":35}]");
  expect_equal(toJSON(data.frame(foo=35L)), "[{\"foo\":35}]");
  expect_equal(toJSON(data.frame(foo=c(35, pi)), digits=5), "[{\"foo\":35},{\"foo\":3.14159}]");
  expect_equal(toJSON(data.frame(foo=pi), digits=0), "[{\"foo\":3}]");
  expect_equal(toJSON(data.frame(foo=pi), digits=2), "[{\"foo\":3.14}]");
  expect_equal(toJSON(data.frame(foo=pi), digits=10), "[{\"foo\":3.1415926536}]");
  expect_equal(toJSON(data.frame(foo=c(pi, NA)), digits=5), "[{\"foo\":3.14159},{}]");
  expect_equal(toJSON(data.frame(foo=c(pi, NA)), na="string", digits=5), "[{\"foo\":3.14159},{\"foo\":\"NA\"}]");
  expect_equal(toJSON(data.frame(foo=c(pi, NA)), na="null", digits=5), "[{\"foo\":3.14159},{\"foo\":null}]");
});

test_that("Force decimal works", {
  # Force decimal for doubles
  expect_equal(toJSON(100), '[100]')
  expect_equal(toJSON(100, always_decimal = TRUE), '[100.0]')
  expect_equal(toJSON(12.000000000001, always_decimal = TRUE), '[12.0]')

  # But not for integers
  expect_equal(toJSON(100L), '[100]')
  expect_equal(toJSON(100L, always_decimal = TRUE), '[100]')

  # Test range
  x <- 10^c(-15 : 20)
  x1 <- c(rev(-x), x)
  x2 <- 1.2345 * x1
  expect_equal(as.list(x1), fromJSON(toJSON(x1), simplifyVector = FALSE))
  expect_equal(as.list(x2), fromJSON(toJSON(x2, digits = 9), simplifyVector = FALSE))

  # always_decimal makes sure that doubles stay real
  y2 <- fromJSON(toJSON(x1, digits = 9, always_decimal = TRUE), simplifyVector = FALSE)
  expect_identical(as.list(x1), y2)
})
