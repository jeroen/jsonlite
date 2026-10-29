nested_json <- function(depth) {
  paste0(strrep("[", depth), "0", strrep("]", depth))
}

test_that("JSON nesting depth is limited", {
  expect_true(is.list(parse_json(nested_json(128))))
  expect_error(
    parse_json(nested_json(129)),
    "Maximum JSON nesting depth \\(128\\) exceeded"
  )
})

test_that("connection parsing applies the nesting limit", {
  input <- textConnection(nested_json(129))
  on.exit(close(input))
  expect_error(parse_json(input))
})
