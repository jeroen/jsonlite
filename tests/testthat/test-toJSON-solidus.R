context("toJSON escape solidus")

test_that("Solidus is escaped properly", {
  script <- list("foo/bar" = "<script>evil()</script>")
  json <- toJSON(script)
  json_safe <- toJSON(script, escape_solidus = TRUE)
  expect_equal(json, '{"foo/bar":["<script>evil()</script>"]}')
  expect_equal(json_safe, '{"foo\\/bar":["<script>evil()<\\/script>"]}')
  expect_identical(fromJSON(json), fromJSON(json_safe))

  # check for data frames and factors
  df <- data.frame(x = pi)
  df[["a/b/c"]] = "<script>evil()</script>"
  df[["script"]] = script
  json <- toJSON(df)
  json_safe <- toJSON(df, escape_solidus = TRUE)
  expect_equal(json, '[{"x":3.1416,"a/b/c":"<script>evil()</script>","script":["<script>evil()</script>"]}]')
  expect_equal(json_safe, '[{"x":3.1416,"a\\/b\\/c":"<script>evil()<\\/script>","script":["<script>evil()<\\/script>"]}]')
  expect_identical(fromJSON(json), fromJSON(json_safe))
})
