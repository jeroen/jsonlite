library(RJSONIO)

stopifnot(is.list(fromJSON('[1, "2.3", "abc"]', simplify = Strict)))

stopifnot(is.character(fromJSON('[1, "2.3", "abc"]', simplify = TRUE)))

stopifnot(is.character(fromJSON('[1, true, "2.3", "abc"]', simplify = TRUE)))

stopifnot(is.list(fromJSON('[1, true, "2.3", "abc"]', simplify = Strict)))

stopifnot(is.list(fromJSON('[1, true]', simplify = Strict)))
stopifnot(is.numeric(fromJSON('[1, true]', simplify = TRUE)))

stopifnot(is.character(fromJSON('["1", true]', simplify = TRUE)))


stopifnot(is.character(fromJSON('{ "a": "1", "b": true}', simplify = TRUE)))
stopifnot(is.list(fromJSON('{ "a": "1", "b": true}', simplify = Strict)))

stopifnot(is.character(fromJSON('{ "a": "1", "b": "true"}', simplify = Strict)))

stopifnot(is.numeric(fromJSON('{ "a": 1, "b": 2}', simplify = Strict)))

stopifnot(is.list(fromJSON('{ "a": 1, "b": 2}', simplify = FALSE)))


is.na(fromJSON(toJSON( c("a", NA, "b", "c")), nullValue = NA, simplify = TRUE))
is.na(fromJSON(toJSON( c(1, NA, 3, 4)), nullValue = NA, simplify = TRUE))

is.na(fromJSON(toJSON( c(TRUE, NA, FALSE, TRUE)), nullValue = NA, simplify = TRUE))



