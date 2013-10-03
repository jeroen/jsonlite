\name{as.scalar}
\alias{as.scalar}
\title{Add class 'scalar' to an object}
\usage{
  as.scalar(obj)
}
\arguments{
  \item{obj}{the R object to classified as scalar.}
}
\value{
  The same R object
}
\description{
  Function simply adds class 'scalar' to the object and
  returns it. Objects of class 'scalar' of length 1 will be
  encoded as a json primitive instead of an array.
}
\examples{
asJSON(list(foo=123));
asJSON(list(foo=as.scalar(123)));
}
\author{
  Jeroen Ooms \email{jeroen.ooms@stat.ucla.edu}
}

