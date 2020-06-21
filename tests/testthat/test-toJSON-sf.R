test_that("Writing SF objects", {
  skip_if_not(require(sf))
  compare_to_geojson <- function(file){
    if(!file.exists(file)){
      warning("Test file not found: ", file)
      return(NULL)
    }
    sf_obj <- sf::st_read(file, quiet = TRUE)
    out <- jsonlite::fromJSON(jsonlite::toJSON(sf_obj, digits = 8))
    tmp <- tempfile(fileext = '.geojson')
    on.exit(unlink(tmp))
    sf::write_sf(sf_obj, tmp, driver = 'GeoJSON')
    geodata <- jsonlite::fromJSON(tmp)
    expect_equal(out$geometry$coordinates, geodata$features$geometry$coordinates)
    expect_equal(out$geometry$type, geodata$features$geometry$type)
  }
  compare_to_geojson(system.file("shape/storms_xyz.shp", package = "sf"))
  compare_to_geojson(system.file("shape/storms_xyzm.shp", package = "sf"))
  compare_to_geojson(system.file("shape/nc.shp", package = "sf"))
})
