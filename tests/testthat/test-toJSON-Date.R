
object <- as.Date("1985-06-18");

test_that("Encoding Date Objects", {
  expect_equal(toJSON(object), "[\"1985-06-18\"]");
  expect_equal(toJSON(object, Date="ISO8601"), "[\"1985-06-18\"]");
  expect_equal(toJSON(object, Date="epoch"), "[5647]");
  expect_error(toJSON(object, Date="adsfdsfds"), "should be one of");
});

test_that("Encoding Date Objects in a list", {
  expect_equal(toJSON(list(foo=object)), "{\"foo\":[\"1985-06-18\"]}");
  expect_equal(toJSON(list(foo=object), Date="ISO8601"), "{\"foo\":[\"1985-06-18\"]}");
  expect_equal(toJSON(list(foo=object), Date="epoch"), "{\"foo\":[5647]}");
  expect_error(toJSON(list(foo=object), Date="adsfdsfds"), "should be one of");
});

test_that("Encoding Date Objects in a Data frame", {
  expect_equal(toJSON(data.frame(foo=object)), "[{\"foo\":\"1985-06-18\"}]");
  expect_equal(toJSON(data.frame(foo=object), Date="ISO8601"), "[{\"foo\":\"1985-06-18\"}]");
  expect_equal(toJSON(data.frame(foo=object), Date="epoch"), "[{\"foo\":5647}]");
  expect_error(toJSON(data.frame(foo=object), Date="adsfdsfds"), "should be one of");
});
