library(RJSONIO)

ff = system.file("sampleData", "keys.json", package = "RJSONIO")
print(ff)
z = paste(readLines(ff), collapse = "\n")

fromJSON(I(z))

fromJSON(ff, function(type, val) { cat(names(type), "\n"); TRUE})

