context("toJSON keep_vec_names")

test_that("keep_vec_names with named vectors", {

  # Basic types should give messages
  # Length-1 vectors
  expect_message(expect_equal(toJSON2(c(a=1)), '{"a":1}'))
  expect_message(expect_equal(toJSON2(c(a="x")), '{"a":"x"}'))
  expect_message(expect_equal(toJSON2(c(a=TRUE)), '{"a":true}'))

  # Longer vectors
  expect_message(expect_equal(toJSON2(c(a=1,b=2)), '{"a":1,"b":2}'))
  expect_message(expect_equal(toJSON2(c(a="x",b="y")), '{"a":"x","b":"y"}'))
  expect_message(expect_equal(toJSON2(c(a=FALSE,b=TRUE)), '{"a":false,"b":true}'))

  # Some other types
  expect_message(expect_equal(toJSON2(factor(c(a="x"))), '{"a":"x"}'))
  expect_message(expect_equal(toJSON2(c(a=as.Date("2015-01-01"))), '{"a":"2015-01-01"}'))
  expect_message(expect_equal(toJSON2(c(a=as.POSIXct("2015-01-01 3:00:00"))), '{"a":"2015-01-01 03:00:00"}'))
  expect_message(expect_equal(toJSON2(c(a=as.POSIXlt("2015-01-01 3:00:00"))), '{"a":"2015-01-01 03:00:00"}'))

  # keep_vec_names shouldn't affect unnamed vectors
  expect_equal(toJSON2(1), '1')
  expect_equal(toJSON2(c(1:3)), '[1,2,3]')
})


# Data frames generally don't allow named columns, except in very unusual cases
test_that("keep_vec_names with data frames", {
  expect_equal(toJSON3(data.frame(x=c(a=1), y=2)), '{"x":[1],"y":[2]}')
  expect_equal(toJSON3(data.frame(x=c(a=1,b=2), y=c(c=3,d=4))), '{"x":[1,2],"y":[3,4]}')
})
