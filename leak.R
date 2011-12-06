library("RJSONIO")
f <- file("inst/sampleData/web.json")
f.lines <- readLines(f)
f.str <- paste(f.lines, collapse = "\n")
ans = vector("list", 1000)
for (x in seq_len(1000)) {
  foo <- fromJSON(I(f.str), asText = TRUE)
  # ans[[x]] = gc()
}

