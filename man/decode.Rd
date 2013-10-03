\name{decode}
\alias{decode}
\title{Decode a JSON string to an R object}
\usage{
  decode(jsonstring, safe = TRUE)
}
\arguments{
  \item{jsonstring}{A character string containing the JSON
  data.}

  \item{safe}{Safe decoding. When FALSE, code will be
  evaluated during decoding.}
}
\value{
  An R object
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
\author{
  Jeroen Ooms \email{jeroen.ooms@stat.ucla.edu}
}
\references{
  \url{http://www.jsonlint.org}
}

