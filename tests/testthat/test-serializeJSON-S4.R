context("Serializing S4 objects")

test_that("Simple S4 serialization", {
  setClass("myClass", slots = list(name = "character"))
  obj <- new("myClass", name = "myName")
  out <- jsonlite::unserializeJSON(jsonlite::serializeJSON(obj))
  expect_identical(obj, out)
  removeClass("myClass")
})

test_that("Serialize optional S4 fields", {
  setClass(
    Class="Trajectories",
    representation = representation(
      times = "numeric",
      traj = "matrix"
    )
  )

  t1 <- new(Class="Trajectories")
  t2 <- new(Class="Trajectories", times=c(1,3,4))
  t3 <- new(Class="Trajectories", times=c(1,3), traj=matrix(1:4,ncol=2))

  expect_identical(t1, unserializeJSON(serializeJSON(t1)))
  expect_identical(t2, unserializeJSON(serializeJSON(t2)))
  expect_identical(t3, unserializeJSON(serializeJSON(t3)))
  removeClass("Trajectories")
})

test_that("Serialize pseudo-null (empty slot)", {
  track <- setClass("track", slots = c(x="numeric", y="ANY"))
  t1 <- new("track", x = 1:3)
  t2 <- unserializeJSON(serializeJSON(t1))
  expect_identical(t1, t2)
})

test_that("Class loading errors", {
  expect_error(unserializeJSON('{"type":"S4","attributes":{},"value":{"class":"nonExitingClass","package":".GlobalEnv"}}'), "defined")
  expect_error(expect_warning(unserializeJSON('{"type":"S4","attributes":{},"value":{"class":"nonExitingClass","package":"nopackage"}}')), "nopackage")
})


# S4 extending various SEXP types
test_that("Serializing S4 extending SEXPTYPE", {

  objects <- list(
    NULL,
    readBin(system.file(package="base", "Meta/package.rds"), "raw", 999),
    c(TRUE, FALSE, NA, FALSE),
    c(1L, NA, 9999999),
    c(round(pi, 4), NA, NaN, Inf, -Inf),
    c("foo", NA, "bar"),
    complex(real=1:10, imaginary=1001:1010),
    expression("to be or not to be"),
    expression(foo),
    parse(text="rnorm(10);"),
    list("1", "2", "3"),
    mtcars,
    base::matrix(nrow=100, ncol=100)
  )

  lapply(objects, function(object){
    setClass("Complexo", contains = c(class(object)))
    complex1 <- new("Complexo", object)
    c1 = serializeJSON(complex1)
    c2 = unserializeJSON(c1)
    expect_identical(complex1, c2)
  })

})
