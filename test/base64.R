#test if raw vectors are serialized properly
x <- paste(readLines(system.file("DESCRIPTION", package="JSONlite")), collapse="\n")
identical(x, rawToChar(JSONlite:::base64_decode(JSONlite:::base64_encode(charToRaw(x)))))
