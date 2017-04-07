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


test_that("Advanced S4 serialization", {
  data(meuse, package = 'sp', envir = environment())
  sp::coordinates(meuse) <- ~x+y
  sp::proj4string(meuse) <- sp::CRS("+init=epsg:28992")
  out <- jsonlite::unserializeJSON(jsonlite::serializeJSON(meuse))
  expect_is(out, "SpatialPointsDataFrame")
  expect_true(isS4(out))
  expect_identical(out, meuse)
})

test_that("Class loading errors", {
  expect_error(unserializeJSON('{"type":"S4","attributes":{},"value":{"class":"nonExitingClass","package":".GlobalEnv"}}'), "defined")
  expect_error(unserializeJSON('{"type":"S4","attributes":{},"value":{"class":"nonExitingClass","package":"nopackage"}}'), "nopackage")
})
