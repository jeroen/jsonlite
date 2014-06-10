context("toJSON Date")
object <- as.Date("1985-06-18");

test_that("Encoding Date Objects", {
  expect_that(toJSON(object), equals("[\"1985-06-18\"]"));
  expect_that(toJSON(object, Date="ISO8601"), equals("[\"1985-06-18\"]"));  
  expect_that(toJSON(object, Date="epoch"), equals("[5647]"));
  expect_that(toJSON(object, Date="adsfdsfds"), throws_error("should be one of"));  
});

test_that("Encoding Date Objects in a list", {
  expect_that(toJSON(list(foo=object)), equals("{\"foo\":[\"1985-06-18\"]}"));
  expect_that(toJSON(list(foo=object), Date="ISO8601"), equals("{\"foo\":[\"1985-06-18\"]}"));  
  expect_that(toJSON(list(foo=object), Date="epoch"), equals("{\"foo\":[5647]}"));
  expect_that(toJSON(list(foo=object), Date="adsfdsfds"), throws_error("should be one of"));  
});

test_that("Encoding Date Objects in a Data frame", {
  expect_that(toJSON(data.frame(foo=object)), equals("[{\"foo\":\"1985-06-18\"}]"));
  expect_that(toJSON(data.frame(foo=object), Date="ISO8601"), equals("[{\"foo\":\"1985-06-18\"}]"));  
  expect_that(toJSON(data.frame(foo=object), Date="epoch"), equals("[{\"foo\":5647}]"));
  expect_that(toJSON(data.frame(foo=object), Date="adsfdsfds"), throws_error("should be one of"));  
});
