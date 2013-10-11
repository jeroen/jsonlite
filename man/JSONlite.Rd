\name{JSONlite}
\alias{JSONlite}
\alias{fromJSON}
\alias{serializeJSON}
\alias{toJSON}
\alias{unserializeJSON}
\title{Stringify R objects to JSON and vice versa.}
\usage{
  fromJSON(txt, simplify = NA)

  toJSON(x, pretty = FALSE, ...)

  serializeJSON(x, ...)

  unserializeJSON(txt, safe = TRUE)
}
\arguments{
  \item{x}{the object to be encoded}

  \item{pretty}{adds indentation whitespace to JSON output}

  \item{txt}{a string in json format}

  \item{simplify}{simplify arrays to vectors where
  possible}

  \item{safe}{don't evaluate language objects during
  unseriazing}

  \item{...}{arguments passed on to class specific methods}
}
\description{
  These functions are used to convert R objects into JSON
  and back. The \code{toJSON} and \code{fromJSON} functions
  use a class schema with a somewhat untuitive encoding.
  This is convenient for clients but can only be used for
  basic R objects and ignores a lot of the object metadata.
  The \code{serializeJSON} and \code{unserializeJSON}
  functions on the other hand use type based encoding which
  includes all metadata and will work for almost any
  object, but output can be very verbose.
}
\details{
  The \code{toJSON} and \code{fromJSON} are drop-in
  replacements for the identically named functions in the
  RJSONIO package. The \code{toJSON} function stringifies
  an R object into JSON, and \code{fromJSON} parses a JSON
  string into an R object. These implementations use an
  alternative, somewhat more consistent mapping between R
  objects and JSON strings.

  The \code{serializeJSON} and \code{unserializeJSON}
  functions also convert R objects to JSON and back, but
  use a much more verbose encoding schema which includes
  all metadata from the object, such that an object can be
  almost perfectly restored from its JSON representation.
}
\note{
  All encoded objects should pass the validation at
  www.jsonlint.org
}
\examples{
#stringify some data
jsoncars <- toJSON(mtcars, pretty=TRUE)
cat(jsoncars)

#parse it back
fromJSON(jsoncars)

#serialize i
jsoncars <- serializeJSON(mtcars)
mtcars2 <- unserializeJSON(jsoncars)
identical(mtcars, mtcars2)

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
identical(unserializeJSON(serializeJSON(myobject)), myobject);
}
\author{
  Jeroen Ooms \email{jeroen.ooms@stat.ucla.edu}
}
\references{
  \url{http://www.jsonlint.org}
}

