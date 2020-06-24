# Wrappers for common classes
setMethod("asJSON", "ts", function(x, ...) {
  asJSON(as.vector(x), ...)
})

# Wrappers for common classes
setMethod("asJSON", "ts", function(x, ...) {
  asJSON(as.vector(x), ...)
})

# For 'sf' geometry columns; use same structure as GeoJSON

geom_to_geojson <- function(x){
  val <- list(
    type = unbox(sf_to_titlecase(sf::st_geometry_type(x)))
  )
  if(inherits(x, "GEOMETRYCOLLECTION")){
    val$geometries = lapply(x, geom_to_geojson)
  } else {
    val$coordinates = unclass(x)
  }
  return(val)
}

setOldClass('sfc')
setMethod("asJSON", "sfc", function(x, ...) {
  y <- lapply(unclass(x), geom_to_geojson)
  asJSON(y, ...)
})

# See sf::sf.tp
sf_to_titlecase <- function(x){
  sf_types <-
    c("Point", "LineString", "Polygon", "MultiPoint", "MultiLineString",
      "MultiPolygon", "GeometryCollection", "CircularString", "CompoundCurve",
      "CurvePolygon", "MultiCurve", "MultiSurface", "Curve", "Surface",
      "PolyhedralSurface", "TIN", "Triangle")
  matches <- match(as.character(x), toupper(sf_types))
  sf_types[matches]
}
