context("toJSON Logical")

test_that("Encoding Logical", {
  expect_that(toJSON(TRUE), equals("[true]"));
  expect_that(toJSON(FALSE), equals("[false]"));
  expect_that(toJSON(as.logical(NA)), equals("[null]"))
  expect_that(toJSON(as.logical(NA), na="string"), equals("[\"NA\"]"))
  expect_that(toJSON(c(TRUE, NA, FALSE)), equals("[true,null,false]"));
  expect_that(toJSON(c(TRUE, NA, FALSE), na="string"), equals("[true,\"NA\",false]"));
  expect_that(toJSON(logical()), equals("[]"));
});

test_that("Encoding Logical in Data Frame", {
  expect_that(toJSON(data.frame(foo=TRUE)), equals("[{\"foo\":true}]"));
  expect_that(toJSON(data.frame(foo=FALSE)), equals("[{\"foo\":false}]"));
  expect_that(toJSON(data.frame(foo=as.logical(NA))), equals("[{}]"));
  expect_that(toJSON(data.frame(foo=as.logical(NA)), na="null"), equals("[{\"foo\":null}]"));
  expect_that(toJSON(data.frame(foo=as.logical(NA)), na="string"), equals("[{\"foo\":\"NA\"}]"));
  expect_that(toJSON(data.frame(foo=c(TRUE, NA, FALSE))), equals("[{\"foo\":true},{},{\"foo\":false}]"));
  expect_that(toJSON(data.frame(foo=logical())), equals("[]"));
});
