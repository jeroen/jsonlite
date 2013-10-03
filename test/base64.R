#test if raw vectors are serialized properly
x <- paste(readLines(system.file("DESCRIPTION", package="encode")), collapse="\n")
identical(x, rawToChar(encode:::base64_decode(encode:::base64_encode(charToRaw(x)))))
