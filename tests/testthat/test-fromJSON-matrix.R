# Note about numeric precision
# In the unit tests we use digits=10. Lowever values will result in problems for some datasets
test_that("fromJSON Matrix", {
  objects <- list(
    matrix(1),
    matrix(1:2),
    matrix(1:2, nrow = 1),
    matrix(round(pi, 2)),
    matrix(c(1, NA, 2, NA), 2),
    volcano,
    matrix(NA)
  )

  lapply(objects, function(object) {
    newobject <- fromJSON(toJSON(object))
    expect_true(inherits(newobject, "matrix"))
    expect_equal(object, newobject)
  })

  expect_equal(fromJSON(toJSON(objects)), objects)
})

test_that("fromJSON Matrix with simplifyMatrix=FALSE", {
  expect_equal(fromJSON(toJSON(matrix(1)), simplifyMatrix = FALSE), list(1))
  expect_equal(fromJSON(toJSON(matrix(1)), simplifyVector = FALSE), list(list((1))))
  expect_equal(fromJSON(toJSON(matrix(NA)), simplifyMatrix = FALSE), list(NA))
  expect_equal(fromJSON(toJSON(matrix(NA)), simplifyVector = FALSE), list(list((NULL))))
})


test_that("fromJSON Matrix datasets", {
  objects <- Filter(is.matrix, lapply(ls("package:datasets"), get))

  lapply(objects, function(object) {
    class(object) <- "matrix"
    newobject <- fromJSON(toJSON(object, digits = 4))
    expect_true(inherits(newobject, "matrix"))
    expect_equal(dim(newobject), dim(object))
    attributes(newobject) <- attributes(object)

    # R has changed rounding algo in 4.0 and no longer matches printf
    #expect_equal(newobject, round(object,4));
    expect_equal(newobject, object, tolerance = 1e-4)
  })
})
