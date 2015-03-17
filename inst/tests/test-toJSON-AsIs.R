context("toJSON AsIs")

test_that("Encoding AsIs", {
  expect_that(toJSON(list(1), auto_unbox=TRUE), equals("[1]"));
  expect_that(toJSON(list(I(1)), auto_unbox=TRUE), equals("[[1]]"));
  expect_that(toJSON(I(list(1)), auto_unbox=TRUE), equals("[1]"));

  expect_that(toJSON(list(x=1)), equals("{\"x\":[1]}"));
  expect_that(toJSON(list(x=1), auto_unbox=TRUE), equals("{\"x\":1}"));
  expect_that(toJSON(list(x=I(1)), auto_unbox=TRUE), equals("{\"x\":[1]}"));

  expect_that(toJSON(list(x=I(list(1))), auto_unbox=TRUE), equals("{\"x\":[1]}"));
  expect_that(toJSON(list(x=list(I(1))), auto_unbox=TRUE), equals("{\"x\":[[1]]}"));
});
