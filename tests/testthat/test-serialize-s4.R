context("Serializing S4 objects")

expect_that("S4 objects get serialized", {

  test_that("Simple S4 serialization", {
    setClass("myClass", slots = list(name = "character"))
    obj <- new("myClass", name = "myName")
    out <- jsonlite::unserializeJSON(jsonlite::serializeJSON(obj))
    expect_identical(obj, out)
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
})
