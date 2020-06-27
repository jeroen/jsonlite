test_that("Writing SF objects", {
  skip_if_not(require(sf))
  compare_to_geojson_obj <- function(sf_obj){
    sf_as_dataframe <- fromJSON(toJSON(sf_obj, digits = 8))
    sf_as_features <- fromJSON(toJSON(sf_obj, sf = 'features', digits = 8))
    geojson_string <- toJSON(sf_obj, sf = 'geojson', digits = 8)
    sf_as_geojson <- parse_json(geojson_string)
    tmp <- file.path(tempdir(), 'sfdata.geojson')
    on.exit(unlink(tmp))
    sf::write_sf(sf_obj, tmp, driver = 'GeoJSON')
    geojson <- fromJSON(tmp)
    geojson_exact <- read_json(tmp)
    geojson_exact$crs = NULL # We don't add CRS because it was deprecated in geojson spec
    expect_equal(sf_as_dataframe[[attr(sf_obj, 'sf_column')]], geojson$features$geometry)
    expect_equal(sf_as_features, geojson$features)
    expect_equal(sf_as_geojson, geojson_exact)
  }

  compare_to_geojson_file <- function(file){
    sf_obj <- sf::st_read(file, quiet = TRUE)
    compare_to_geojson_obj(sf_obj)
    compare_to_geojson_obj(sf_obj[1,])
    compare_to_geojson_obj(sf_obj[0,])
  }

  # Test with some standard data
  compare_to_geojson_file(system.file("shape/storms_xyz.shp", package = "sf"))
  compare_to_geojson_file(system.file("shape/nc.shp", package = "sf"))
  #compare_to_geojson_file(system.file("examples", "us_states.topojson", package = "geojsonio"))

  # Test special types, from ?st examples
  outer = matrix(c(0,0,10,0,10,10,0,10,0,0.0), ncol=2, byrow=TRUE)
  hole1 = matrix(c(1,1,1,2,2,2,2,1,1,1.0), ncol=2, byrow=TRUE)
  hole2 = matrix(c(5,5,5,6,6,6,6,5,5,5.0), ncol=2, byrow=TRUE)
  pts = list(outer, hole1, hole2)
  ml1 = st_multilinestring(pts)
  pl1 = st_polygon(pts)
  pol1 = list(outer, hole1, hole2)
  pol2 = list(outer + 12, hole1 + 12)
  pol3 = list(outer + 24)
  mpl1 = st_multipolygon(list(pol1,pol2,pol3))
  p1 = st_point(as.double(1:2))
  mp1 = st_multipoint(matrix(as.double(1:10), ncol = 2))
  ls1 = st_linestring(matrix(as.double(1:10), ncol = 2))
  gcol = st_geometrycollection(list(p1, ls1, pl1, mp1))
  geometry = st_sfc(
    p1,
    mp1,
    ls1,
    ml1,
    pl1,
    mpl1,
    gcol
  )
  sf_obj <- st_sf(geoms = geometry)
  compare_to_geojson_obj(sf_obj)

  # One very strict test
  geojson_string <- toJSON(sf_obj, sf = 'geojson', always_decimal = TRUE, digits = 8)
  tmp <- file.path(tempdir(), 'sfdata.geojson')
  on.exit(unlink(tmp))
  sf::write_sf(sf_obj, tmp, driver = 'GeoJSON')
  expect_equal(minify(geojson_string), minify(readLines(tmp)))
})
