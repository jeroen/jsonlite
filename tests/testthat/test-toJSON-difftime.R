context("toJSON difftime")
objectSecs <- as.POSIXct("1985-06-18 14:23:00") - (as.POSIXct("1985-06-18 14:23:00") - 2);
objectMins <- as.POSIXct("1985-06-18 14:23:00") - (as.POSIXct("1985-06-18 14:23:00") - 120);
objectHours <- as.POSIXct("1985-06-18 14:23:00") - (as.POSIXct("1985-06-18 14:23:00") - 7200);
objectDays <- as.POSIXct("1985-06-18 14:23:00")- (as.POSIXct("1985-06-18 14:23:00") - 172800);

test_that("Encoding difftime Objects", {
  expect_that(toJSON(objectSecs), equals("[\"2 secs\"]"));
  expect_that(toJSON(objectMins), equals("[\"2 mins\"]"));
  expect_that(toJSON(objectHours), equals("[\"2 hours\"]"));
  expect_that(toJSON(objectDays), equals("[\"2 days\"]"));

  expect_that(toJSON(objectSecs, difftime = "string"), equals("[\"2 secs\"]"));
  expect_that(toJSON(objectMins, difftime = "string"), equals("[\"2 mins\"]"));
  expect_that(toJSON(objectHours, difftime = "string"), equals("[\"2 hours\"]"));
  expect_that(toJSON(objectDays, difftime = "string"), equals("[\"2 days\"]"));

  expect_that(toJSON(objectSecs, difftime = "epoch"), equals("[2]"));
  expect_that(toJSON(objectMins, difftime = "epoch"), equals("[120]"));
  expect_that(toJSON(objectHours, difftime = "epoch"), equals("[7200]"));
  expect_that(toJSON(objectDays, difftime = "epoch"), equals("[172800]"));

  expect_that(toJSON(objectSecs, difftime="adsfdsfds"), throws_error("should be one of"));

});

test_that("Encoding difftime Objects in a list", {
  expect_that(toJSON(list(foo=objectSecs)), equals("{\"foo\":[\"2 secs\"]}"));
  expect_that(toJSON(list(foo=objectSecs), difftime="string"), equals("{\"foo\":[\"2 secs\"]}"));
  expect_that(toJSON(list(foo=objectSecs), difftime="epoch"), equals("{\"foo\":[2]}"));
  expect_that(toJSON(list(foo=objectSecs), difftime="adsfdsfds"), throws_error("should be one of"));
});

test_that("Encoding Date Objects in a Data frame", {
  expect_that(toJSON(data.frame(foo=objectSecs)), equals("[{\"foo\":\"2 secs\"}]"));
  expect_that(toJSON(data.frame(foo=objectSecs), difftime="string"), equals("[{\"foo\":\"2 secs\"}]"));
  expect_that(toJSON(data.frame(foo=objectSecs), difftime="epoch"), equals("[{\"foo\":2}]"));
  expect_that(toJSON(data.frame(foo=objectSecs), difftime="adsfdsfds"), throws_error("should be one of"));
});
