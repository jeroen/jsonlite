library(RJSONIO)

con = textConnection(c("[[1,2,3,4],", "[5, 6, 7, 8]]"))
fromJSON(con)

con = file(system.file("sampleData", "usaPolygons.as", package = "RJSONIO"))
o = fromJSON(con)



