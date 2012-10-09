library(RJSONIO)

roundTrip =
  # compare can be all.equal
function(x, y = x, simplify = TRUE, asIs = NA, compare = identical) {
  ans <- fromJSON(toJSON(x, asIs = asIs), simplify = simplify)
  compare(ans, y)
}

stopifnot(roundTrip(c(TRUE, FALSE)))
stopifnot(roundTrip(TRUE))
try(stopifnot(roundTrip(1L))) # fails since 1L becomes a numeric
stopifnot(roundTrip(1))
stopifnot(roundTrip("xyz"))

stopifnot(roundTrip(c(TRUE, FALSE)))
stopifnot(roundTrip(1:2, as.numeric(1:2)))
stopifnot(roundTrip(c(1, 2, 3)))
stopifnot(roundTrip(c("abc", "xyz")))

# with names
stopifnot(roundTrip(c(a = TRUE)))
stopifnot(roundTrip(c(a = 1)))
stopifnot(roundTrip(c(a = "xyz")))
stopifnot(roundTrip(c(a = 1L), c(a = 1)))


# lists

stopifnot(roundTrip(list(1L), asIs = FALSE, simplify = FALSE, list(1)))

# 
stopifnot(roundTrip(list(1, 2), asIs = FALSE, simplify = FALSE, list(1, 2)))
stopifnot(roundTrip(list(1, 2), asIs = TRUE, simplify = FALSE, list(list(1), list(2))))

stopifnot(roundTrip(list(a= 1, b = 2), asIs = TRUE, simplify = FALSE, list(a = list(1), b = list(2))))


#
tmp = list(a = 1, b = c(1, 2), c = list(1:3, x = c(TRUE, FALSE, FALSE), list(c("a", "b", "c", "d"))))
tmp1 = fromJSON(toJSON(tmp))
all.equal(tmp, tmp1)

roundTrip(tmp, compare = all.equal)
