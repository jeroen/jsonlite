test_that("Encoding raw vector", {
  x <- list(myraw = charToRaw("bla"))
  x$mydf <- data.frame(foo = 1:3)
  x$mydf$bar <- as.character.hexmode(charToRaw("bla"))

  y <- fromJSON(toJSON(x))
  expect_identical(x$mydf$bar, y$mydf$bar)
  expect_identical(y$myraw, "Ymxh")

  # Serialize raw as int
  y <- fromJSON(toJSON(x, raw = 'int'))
  expect_equal(y$myraw, as.integer(x$myraw))

  # Serialize raw as hex
  y <- fromJSON(toJSON(x, raw = 'hex'))
  expect_equal(y$myraw, as.character.hexmode(x$myraw))

  # Serialize raw as JavaScript
  x <- list(myraw = charToRaw("bla"))
  expect_equal(toJSON(x, raw = 'js'), '{"myraw":(new Uint8Array([98,108,97]))}')
})

test_that("Encoding blob vector", {
  x <- structure(list(raw(2), raw(3)), class = c("blob", "list"))
  expect_equal(toJSON(x), '["AAA=","AAAA"]')
})
