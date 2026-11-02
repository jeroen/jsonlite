nested_array <- function(depth) {
  paste0(strrep("[", depth), "0", strrep("]", depth))
}

nested_object <- function(depth) {
  paste0(strrep('{"a":', depth), "0", strrep("}", depth))
}

parse_raw_connection <- function(json) {
  con <- rawConnection(charToRaw(json))
  on.exit(close(con))
  parse_json(con)
}

# Use an exiting handler: calling handlers (e.g. expect_error) run at the
# point of the stack overflow and may overflow again.
catch_error <- function(expr) {
  tryCatch(expr, error = identity)
}

test_that("deeply nested json is supported", {
  x <- parse_json(nested_array(1000))
  for (i in 1:1000) x <- x[[1]]
  expect_equal(x, 0L)
  expect_type(parse_json(nested_object(1000)), "list")
  expect_type(parse_raw_connection(nested_array(1000)), "list")
})

test_that("excessively nested json raises a catchable error", {
  expect_s3_class(catch_error(parse_json(nested_array(1e5))), "error")
  expect_s3_class(catch_error(parse_json(nested_object(1e5))), "error")
  expect_s3_class(catch_error(parse_raw_connection(nested_array(1e5))), "error")
})
