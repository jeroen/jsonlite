objects <- list(
  as.POSIXlt("2013-06-17 22:33:44"),
  as.POSIXct("2013-06-17 22:33:44"),
  as.POSIXlt("2013-06-17 22:33:44", tz = "Australia/Darwin"),
  as.POSIXct("2013-06-17 22:33:44", tz = "Australia/Darwin")
)

test_that("Encoding POSIXt Objects", {
  #string based formats do not depends on the current local timezone
  invisible(lapply(objects, function(object) {
    expect_equal(toJSON(object), "[\"2013-06-17 22:33:44\"]")
    expect_equal(toJSON(object, POSIXt = "string"), "[\"2013-06-17 22:33:44\"]")
    expect_equal(toJSON(object, POSIXt = "ISO8601"), "[\"2013-06-17T22:33:44\"]")
    expect_error(toJSON(object, POSIXt = "sdfsdsdf"), "one of")
  }))

  #object 1 and 2 will result in a location specific epoch
  invisible(lapply(objects[3:4], function(object) {
    expect_equal(toJSON(object, POSIXt = "epoch"), "[1371474224000]")
    expect_equal(toJSON(object, POSIXt = "mongo"), "[{\"$date\":1371474224000}]")
  }))
})

test_that("Encoding POSIXt object in a list", {
  #string based formats do not depends on the current local timezone
  invisible(lapply(objects, function(object) {
    expect_equal(toJSON(list(foo = object)), "{\"foo\":[\"2013-06-17 22:33:44\"]}")
    expect_equal(toJSON(list(foo = object), POSIXt = "string"), "{\"foo\":[\"2013-06-17 22:33:44\"]}")
    expect_equal(toJSON(list(foo = object), POSIXt = "ISO8601"), "{\"foo\":[\"2013-06-17T22:33:44\"]}")
    expect_error(toJSON(list(foo = object), POSIXt = "sdfsdsdf"), "one of")
  }))

  #list(foo=object) 1 and 2 will result in a location specific epoch
  invisible(lapply(objects[3:4], function(object) {
    expect_equal(toJSON(list(foo = object), POSIXt = "epoch"), "{\"foo\":[1371474224000]}")
    expect_equal(toJSON(list(foo = object), POSIXt = "mongo"), "{\"foo\":[{\"$date\":1371474224000}]}")
  }))
})

test_that("Encoding POSIXt object in a list", {
  #string based formats do not depends on the current local timezone
  invisible(lapply(objects, function(object) {
    expect_equal(toJSON(data.frame(foo = object)), "[{\"foo\":\"2013-06-17 22:33:44\"}]")
    expect_equal(toJSON(data.frame(foo = object), POSIXt = "string"), "[{\"foo\":\"2013-06-17 22:33:44\"}]")
    expect_equal(toJSON(data.frame(foo = object), POSIXt = "ISO8601"), "[{\"foo\":\"2013-06-17T22:33:44\"}]")
    expect_error(toJSON(data.frame(foo = object), POSIXt = "sdfsdsdf"), "one of")
  }))

  #list(foo=object) 1 and 2 will result in a location specific epoch
  invisible(lapply(objects[3:4], function(object) {
    expect_equal(toJSON(data.frame(foo = object), POSIXt = "epoch"), "[{\"foo\":1371474224000}]")
    expect_equal(toJSON(data.frame(foo = object), POSIXt = "mongo"), "[{\"foo\":{\"$date\":1371474224000}}]")
  }))
})

test_that("POSIXt NA values", {
  newobj <- list(
    c(objects[[1]], NA),
    c(objects[[2]], NA)
  )
  lapply(newobj, function(object) {
    expect_equal(toJSON(object), "[\"2013-06-17 22:33:44\",null]")
    expect_equal(toJSON(object, na = "string"), "[\"2013-06-17 22:33:44\",\"NA\"]")
    expect_equal(toJSON(data.frame(foo = object)), "[{\"foo\":\"2013-06-17 22:33:44\"},{}]")
    expect_equal(toJSON(data.frame(foo = object), na = "null"), "[{\"foo\":\"2013-06-17 22:33:44\"},{\"foo\":null}]")
    expect_equal(toJSON(data.frame(foo = object), na = "string"), "[{\"foo\":\"2013-06-17 22:33:44\"},{\"foo\":\"NA\"}]")
  })

  tzobj <- list(
    c(objects[[3]], NA),
    c(objects[[4]], NA)
  )
  lapply(tzobj, function(object) {
    expect_equal(toJSON(object, POSIXt = "mongo"), "[{\"$date\":1371474224000},null]")
    expect_equal(toJSON(object, POSIXt = "mongo", na = "string"), "[{\"$date\":1371474224000},\"NA\"]")
    expect_equal(toJSON(data.frame(foo = object), POSIXt = "mongo"), "[{\"foo\":{\"$date\":1371474224000}},{}]")
    expect_equal(toJSON(data.frame(foo = object), POSIXt = "mongo", na = "null"), "[{\"foo\":{\"$date\":1371474224000}},{\"foo\":null}]")
    expect_equal(toJSON(data.frame(foo = object), POSIXt = "mongo", na = "string"), "[{\"foo\":{\"$date\":1371474224000}},{\"foo\":\"NA\"}]")
  })
})

test_that("Negative dates", {
  x <- objects[[2]]
  y <- x - c(1e9, 2e9, 3e9)
  expect_equal(fromJSON(toJSON(y, POSIXt = "mongo")), y)
})
