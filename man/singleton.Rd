\name{singleton}
\alias{singleton}
\title{Mark a vector or data frame as singleton}
\usage{
  singleton(x)
}
\arguments{
  \item{x}{a vector of length 1, or data frame with 1 row.}
}
\value{
  Returns a singleton version of \code{x}.
}
\description{
  This function marks a vector or data frame as a
  \href{http://en.wikipedia.org/wiki/Singleton_(mathematics)}{singleton},
  i.e. a set with exactly 1 element. Thereby, the value
  will not turn into an \code{array} when encoded into
  \code{JSON}. This can only be done for vectors of length
  1, or data frames with exactly 1 row. Because this
  function alters how R objects are encoded, it should be
  used very sparsely, if at all.
}
\details{
  It is highly recommended to avoid this function and stick
  with the default encoding schema for the various R
  classes. Note that the default encoding for data frames
  naturally results in a collection of key-value pairs,
  without using \code{singleton}. If you are frequently
  using \code{singleton}, you're probably doing it wrong.
  The only use case for this function is if you are bound
  to some specific predifined \code{JSON} structure (e.g.
  to submit to an API), which has no natural R
  representation.
}
\examples{
toJSON(list(foo=123))
toJSON(list(foo=singleton(123)))

x <- iris[1,]
toJSON(list(rec=x))
toJSON(list(rec=singleton(x)))
}
\references{
  \url{http://en.wikipedia.org/wiki/Singleton_(mathematics)}
}

