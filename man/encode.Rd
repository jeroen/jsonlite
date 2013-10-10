\name{encode}
\alias{encode}
\title{Encode an R object to standardized JSON notation}
\usage{
  encode(obj, ...)
}
\arguments{
  \item{obj}{the R object to be encoded}

  \item{...}{arguments for asJSON}
}
\value{
  A valid JSON string
}
\description{
  A standard json encoding has been defined to store S3
  data objects in a way that they will can be (almost)
  completely restored.
}
\note{
  All encoded objects should pass the validation at
  www.jsonlint.org
}
\examples{
jsoncars <- encode(cars);
cat(jsoncars);
identical(decode(jsoncars), cars);

# note that because of rounding, randomness and environments, 'identical'
# is actually too strict.
set.seed('123')
myobject <- list(
  mynull = NULL,
  mycomplex = lapply(eigen(matrix(-rnorm(9),3)), round, 3),
  mymatrix = round(matrix(rnorm(9), 3),3),
  myint = as.integer(c(1,2,3)),
  mydf = cars,
  mylist = list(foo="bar", 123, NA, NULL, list("test")),
  mylogical = c(TRUE,FALSE,NA),
  mychar = c("foo", NA, "bar"),
  somemissings = c(1,2,NA,NaN,5, Inf, 7 -Inf, 9, NA),
  myrawvec = charToRaw("This is a test")
);
identical(decode(encode(myobject)), myobject);
}
\author{
  Jeroen Ooms \email{jeroen.ooms@stat.ucla.edu}
}
\references{
  \url{http://www.jsonlint.org}
}

