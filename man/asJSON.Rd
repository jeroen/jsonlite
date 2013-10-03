\name{asJSON}
\alias{asJSON}
\alias{asJSON,ANY-method}
\alias{asJSON,AsIs-method}
\alias{asJSON,character-method}
\alias{asJSON,classRepresentation-method}
\alias{asJSON,complex-method}
\alias{asJSON,data.frame-method}
\alias{asJSON,Date-method}
\alias{asJSON,factor-method}
\alias{asJSON,int64-method}
\alias{asJSON,integer-method}
\alias{asJSON,list-method}
\alias{asJSON,logical-method}
\alias{asJSON,matrix-method}
\alias{asJSON,NULL-method}
\alias{asJSON,numeric-method}
\alias{asJSON,POSIXt-method}
\alias{asJSON,raw-method}
\alias{asJSON,scalar-method}
\title{Serialize an R object to JSON.}
\arguments{
  \item{x}{the object to be serialized}

  \item{pretty}{does some post pretty printing.}
}
\value{
  A valid JSON string
}
\description{
  This is a slightly modified version of the asJSON
  function in RJSONIO. This function is mostly for internal
  use. Please use opencpu.encode instead.
}
\note{
  All encoded objects should pass the validation at
  www.jsonlint.org
}
\examples{
jsoncars <- asJSON(cars, pretty=TRUE);
cat(jsoncars);
}
\author{
  Jeroen Ooms \email{jeroen.ooms@stat.ucla.edu}
}
\references{
  \url{http://www.jsonlint.org}
}

