test_that("Indent sizes", {
  x <- list(
    df = mtcars[1:10, ],
    mat = matrix(1:6, 2),
    lst = list(
      c(42, NA),
      c(TRUE, FALSE, NA),
      c("foo", "bar", NA_character_)
    )
  )
  for (indent in -8:8) {
    y1 <- fromJSON(toJSON(x, pretty = indent))
    y2 <- unserializeJSON(serializeJSON(x, pretty = indent))
    expect_equal(y1, y2)
  }
})
