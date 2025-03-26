test_that("Encoding Complex", {
  expect_equal(toJSON(complex(real = 2, imaginary = 2)), "[\"2+2i\"]")
  expect_equal(toJSON(complex(real = NA, imaginary = 2)), "[\"NA\"]")
  expect_equal(toJSON(complex(real = 1, imaginary = NA)), "[\"NA\"]")
  expect_equal(toJSON(complex(real = NA, imaginary = 2), na = "null"), "[null]")
})

test_that("Encoding Complex in Data Frame", {
  expect_equal(toJSON(data.frame(foo = complex(real = 1, imaginary = 2))), "[{\"foo\":\"1+2i\"}]")
  expect_equal(toJSON(data.frame(foo = complex(real = NA, imaginary = 2))), "[{}]")
  expect_equal(toJSON(data.frame(foo = complex(real = NA, imaginary = 2)), na = "string"), "[{\"foo\":\"NA\"}]")
  expect_equal(toJSON(data.frame(foo = complex(real = NA, imaginary = 2)), na = "null"), "[{\"foo\":null}]")
})

test_that("Encoding Complex as list", {
  x <- complex(real = c(1, 2, NA), imaginary = 3:1)
  expect_equal(toJSON(x), "[\"1+3i\",\"2+2i\",\"NA\"]")
  expect_equal(toJSON(x, complex = "list"), "{\"real\":[1,2,\"NA\"],\"imaginary\":[3,2,1]}")
  expect_equal(toJSON(data.frame(foo = x), complex = "list"), "[{\"foo\":{\"real\":1,\"imaginary\":3}},{\"foo\":{\"real\":2,\"imaginary\":2}},{\"foo\":{\"imaginary\":1}}]")
  expect_equal(toJSON(data.frame(foo = x), complex = "list", na = "string"), "[{\"foo\":{\"real\":1,\"imaginary\":3}},{\"foo\":{\"real\":2,\"imaginary\":2}},{\"foo\":{\"real\":\"NA\",\"imaginary\":1}}]")
  expect_equal(toJSON(data.frame(foo = x), complex = "list", dataframe = "columns"), "{\"foo\":{\"real\":[1,2,\"NA\"],\"imaginary\":[3,2,1]}}")
})
