library(JSONlite)

test <- data.frame(num=rnorm(10));
test$int <- as.integer(-4:5);
test$factor <- sample(iris$Species,10);
test$char <- paste("foo", 1:10)
test$date <- as.Date(Sys.time()) - 1:10;
test$time <- Sys.time() - 1:10;
test$time2 <- as.POSIXlt(test$time);
#test$raw <- lapply(as.list(test$char), charToRaw)
test$namedlist <- list("foo" = c("bar", "baz"))
test$unnamedlist <- list(c("bar", "baz"))
test$complex <- complex(re=rnorm(10), im=rnorm(10))

for(i in 1:50) test[sample(nrow(test),1), sample(names(test),1)] <- NA
test[10,] <- NA;

cat(toJSON(test, pretty=TRUE))
cat(toJSON(test, Date="epoch", POSIXt="epoch", pretty=TRUE))
cat(toJSON(test, pretty=TRUE, POSIXt="mongo", raw="mongo"))
cat(toJSON(test, drop.na=FALSE, pretty=TRUE))
cat(mongoexport(test))

#should be nearly identical:
simplifyDataFrame(fromJSON(toJSON(test)), columns=names(test), flatten=FALSE);

#default should be OK:
simplifyDataFrame(fromJSON(toJSON(test)))

#test force
toJSON(test)

#encode a single column
decode(encode(test[9], pretty=T))

cat(encode(test[9], pretty=T))
