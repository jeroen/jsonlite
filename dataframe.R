library(RJSONIO)
DF <- head(cars)
DF[1,1] <- NA
cat(toJSON(DF))

outDF = toJSON(DF)
tmp <- fromJSON(content = outDF, asText = TRUE, simplify = TRUE, nullValue = NA)
as.data.frame(tmp)

#origDF <- as.data.frame(lapply(reconstruction, "unlist"))
