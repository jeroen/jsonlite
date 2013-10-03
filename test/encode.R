set.seed("123")
myobject <- list(
		mynull = NULL,
		mycomplex = lapply(eigen(matrix(-rnorm(9),3)), round, 3),
		dates = as.Date(Sys.time()) - 1:3,
		posixlt = round(as.POSIXlt(Sys.time())),
		posixct = structure(round(as.numeric(Sys.time())), class=c("POSIXct", "POSIXt")),
		mymatrix = round(matrix(rnorm(9), 3),3),
		myint = as.integer(c(1,2,3)),
		mydf = cars,
		mylist = list(foo="bar", 123, NA, NULL, list("test")),
		mylogical = c(TRUE,FALSE,NA),
		mychar = c("foo", NA, "bar"),
		somemissings = c(1,2,NA,NaN,5, Inf, 7 -Inf, 9, NA),
		myrawvec = charToRaw("This is a test")
);

identical(decode(encode(myobject)), myobject)
identical(decode(encode(myobject, POSIX_as_string=FALSE)), myobject)
