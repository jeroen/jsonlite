\name{toJSON}
\alias{toJSON}
\title{Stringify an R object to JSON.}
\usage{
  toJSON(x, pretty = FALSE, ...)
}
\arguments{
  \item{x}{the object to be serialized}

  \item{pretty}{does some post pretty printing.}

  \item{...}{arguments passed on to class specific methods}
}
\value{
  A valid JSON string
}
\description{
  This is a modified version of the toJSON function in
  RJSONIO.
}
\note{
  All encoded objects should pass the validation at
  www.jsonlint.org
}
\examples{
jsoncars <- toJSON(mtcars, pretty=TRUE);
cat(jsoncars);
}
\author{
  Jeroen Ooms \email{jeroen.ooms@stat.ucla.edu}
}
\references{
  \url{http://www.jsonlint.org}
}

