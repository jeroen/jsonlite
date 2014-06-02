## ----echo=FALSE----------------------------------------------------------
library(jsonlite)


## ------------------------------------------------------------------------
txt <- '[12, 3, 7]'
x <- fromJSON(txt)
is(x)
print(x)


## ----eval=FALSE----------------------------------------------------------
## library(testthat)
## test_package("jsonlite")


## ------------------------------------------------------------------------
x <- c(1, 2, pi)
toJSON(x)


## ------------------------------------------------------------------------
x <- c(TRUE, FALSE, NA)
toJSON(x)


## ------------------------------------------------------------------------
x <- c(1,2,NA,NaN,Inf,10)
toJSON(x)


## ------------------------------------------------------------------------
toJSON(c(TRUE, NA, NA, FALSE))
toJSON(c("FOO", "BAR", NA, "NA"))
toJSON(c(3.14, NA, NaN, 21, Inf, -Inf))

#Non-default behavior
toJSON(c(3.14, NA, NaN, 21, Inf, -Inf), na="null")


## ------------------------------------------------------------------------
toJSON(Sys.time() + 1:3)
toJSON(as.Date(Sys.time()) + 1:3)
toJSON(factor(c("foo", "bar", "foo")))
toJSON(complex(real=runif(3), imaginary=rnorm(3)))


## ------------------------------------------------------------------------
#vectors of length 0 and 1
toJSON(vector())
toJSON(pi)

#vectors of length 0 and 1 in a named list
toJSON(list(foo=vector()))
toJSON(list(foo=pi))

#vectors of length 0 and 1 in an unnamed list
toJSON(list(vector()))
toJSON(list(pi))


## ------------------------------------------------------------------------
# Other packages make different choices:
cat(rjson::toJSON(list(n = c(1))))
cat(rjson::toJSON(list(n = c(1, 2))))


## ------------------------------------------------------------------------
x <- matrix(1:12, nrow=3, ncol=4)
print(x)
print(x[2,4])


## ------------------------------------------------------------------------
attributes(volcano)
length(volcano)


## ------------------------------------------------------------------------
x <- matrix(1:12, nrow=3, ncol=4)
toJSON(x)


## ------------------------------------------------------------------------
x <- matrix(c(1,2,4,NA), nrow=2)
toJSON(x)
toJSON(x, na="null")
toJSON(matrix(pi))


## ------------------------------------------------------------------------
x <- matrix(c(NA,1,2,5,NA,3), nrow=3)
row.names(x) <- c("Joe", "Jane", "Mary");
colnames(x) <- c("Treatment A", "Treatment B")
print(x)
toJSON(x)


## ------------------------------------------------------------------------
library(reshape2)
y <- melt(x, varnames=c("Subject", "Treatment"))
print(y)
toJSON(y, pretty=TRUE)


## ------------------------------------------------------------------------
toJSON(as.data.frame(x), pretty=TRUE)


## ------------------------------------------------------------------------
mylist1 <- list("foo" = 123, "bar"= 456)
print(mylist1$bar)
mylist2 <- list(123, 456)
print(mylist2[[2]])


## ------------------------------------------------------------------------
toJSON(list(c(1,2), "test", TRUE, list(c(1,2))))


## ------------------------------------------------------------------------
x <- list(c(1,2,NA), "test", FALSE, list(foo="bar"))
identical(fromJSON(toJSON(x)), x)


## ------------------------------------------------------------------------
toJSON(list(foo=c(1,2), bar="test"))


## ----tidy=FALSE----------------------------------------------------------
toJSON(list(foo=list(bar=list(baz=pi))))


## ------------------------------------------------------------------------
x <- list(foo=123, "test", TRUE)
attr(x, "names")
x$foo
x[[2]]


## ------------------------------------------------------------------------
x <- list(foo=123, "test", TRUE)
print(x)
toJSON(x)


## ------------------------------------------------------------------------
is(iris)
names(iris)
print(iris[1:3, c(1,5)])
print(iris[1:3, c("Sepal.Width", "Species")])


## ------------------------------------------------------------------------
toJSON(iris[1:2,], pretty=TRUE)


## ------------------------------------------------------------------------
toJSON(list(list(Species="Foo", Width=21)), pretty=TRUE)


## ------------------------------------------------------------------------
x <- data.frame(foo=c(FALSE, TRUE,NA,NA), bar=c("Aladdin", NA, NA, "Mario"))
print(x)
toJSON(x, pretty=TRUE)


## ----tidy=TRUE-----------------------------------------------------------
options(stringsAsFactors=FALSE)
x <- data.frame(driver = c("Bowser", "Peach"), occupation = c("Koopa", "Princess"))
x$vehicle <- data.frame(model = c("Piranha Prowler", "Royal Racer"))
x$vehicle$stats <- data.frame(speed = c(55, 34), weight = c(67, 24), drift = c(35, 32))
str(x)
toJSON(x, pretty=TRUE)
myjson <- toJSON(x)
y <- fromJSON(myjson)
identical(x,y)


## ------------------------------------------------------------------------
y <- fromJSON(myjson, flatten=TRUE)
str(y)


## ------------------------------------------------------------------------
x <- data.frame(author = c("Homer", "Virgil", "Jeroen"))
x$poems <- list(c("Iliad", "Odyssey"), c("Eclogues", "Georgics", "Aeneid"), vector());
names(x)
toJSON(x, pretty = TRUE)


## ----tidy=FALSE----------------------------------------------------------
x <- data.frame(author = c("Homer", "Virgil", "Jeroen"))
x$poems <- list(
 data.frame(title=c("Iliad", "Odyssey"), year=c(-1194, -800)),
 data.frame(title=c("Eclogues", "Georgics", "Aeneid"), year=c(-44, -29, -19)),
 data.frame()
)
toJSON(x, pretty=TRUE)


## ------------------------------------------------------------------------
#Heterogeneous lists are bad!
x <- list("FOO", 1:3, list("bar"=pi))
toJSON(x)


## ------------------------------------------------------------------------
#conceptually homogenous array
x <- data.frame(name=c("Jay", "Mary", NA, NA), gender=c("M", NA, NA, "F"))
toJSON(x, pretty=TRUE)


## ----tidy=FALSE----------------------------------------------------------
x <- list(
  humans = data.frame(name = c("Jay", "Mary"), married = c(TRUE, FALSE)),
  horses = data.frame(name = c("Star", "Dakota"), price = c(5000, 30000))
)
toJSON(x, pretty=TRUE)


