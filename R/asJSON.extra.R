# Wrappers for common classes
setMethod("asJSON", "ts", function(x, ...) {
  asJSON(as.vector(x), ...)
})

# For 'sf' geometry columns; use same structure as GeoJSON
setOldClass('sfc')
setMethod("asJSON", "sfc", function(x, ...) {
  types <- sf::st_geometry_type(x)
  df <- structure(list(
    type = sf_to_titlecase(types),
    coordinates = unclass(x)
  ), class = 'data.frame', row.names = seq_along(types))
  asJSON(df, ...)
})

setOldClass('XY')
setMethod("asJSON", "XY", function(x, ...) {
  asJSON(unclass(x), ...)
})

setOldClass('XY')
setMethod("asJSON", "XYZ", function(x, ...) {
  asJSON(unclass(x), ...)
})

setOldClass('XYM')
setMethod("asJSON", "XYM", function(x, ...) {
  asJSON(unclass(x)[,1:2, drop = FALSE], ...)
})

setOldClass('XYZM')
setMethod("asJSON", "XYZM", function(x, ...) {
  asJSON(unclass(x)[,1:3, drop = FALSE], ...)
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
