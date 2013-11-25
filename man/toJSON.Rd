\name{toJSON}
\alias{fromJSON}
\alias{toJSON}
\title{Stringify R objects to JSON and vice versa}
\usage{
  fromJSON(txt, simplifyVector = TRUE,
    simplifyDataFrame = simplifyVector,
    simplifyMatrix = simplifyVector)

  toJSON(x, dataframe = c("rows", "columns"),
    Date = c("ISO8601", "epoch"),
    POSIXt = c("string", "ISO8601", "epoch", "mongo"),
    factor = c("string", "integer"),
    complex = c("string", "list"),
    raw = c("base64", "hex", "mongo"),
    na = c("default", "null", "string"), digits = 2,
    pretty = FALSE, ...)
}
\arguments{
  \item{x}{the object to be encoded}

  \item{dataframe}{how to encode data.frame objects: must
  be one of "row" or "column"}

  \item{Date}{how to encode Date objects: must be one of
  "ISO8601" or "epoch"}

  \item{POSIXt}{how to encode POSIXt (datetime) objects:
  must be one of "string", "ISO8601", "epoch" or "mongo"}

  \item{factor}{how to encode factor objects: must be one
  of "string" or "integer"}

  \item{complex}{how to encode complex numbers: must be one
  of "string" or "list"}

  \item{raw}{how to encode raw objects: must be one of
  "base64", "hex" or "mongo"}

  \item{digits}{max number of digits (after the dot) to
  print for numeric values}

  \item{na}{how to print NA values. One of "default",
  "null" or "string"}

  \item{pretty}{adds indentation whitespace to JSON output.
  See \code{\link{prettify}}}

  \item{txt}{a string in json format}

  \item{simplifyVector}{automatically coerse JSON arrays
  containing only scalars into a vector}

  \item{simplifyDataFrame}{automatically coerse JSON arrays
  containing records (JSON objects with scalars) into a
  data frame.}

  \item{simplifyMatrix}{automatically coerse JSON arrays
  with vectors of equal length and mode into a matrix}

  \item{...}{arguments passed on to class specific
  \code{print} methods}
}
\description{
  These functions are used to convert R objects into JSON
  and back. The \code{\link{toJSON}} and
  \code{\link{fromJSON}} functions use a class based
  encoding schema which follows conventions outlines in the
  vignette of this package. They implement a consitent and
  practical mapping between JSON structures and the
  standard data structures in R.
}
\details{
  The \code{\link{toJSON}} and \code{\link{fromJSON}}
  functions are drop-in replacements for the identically
  named functions in packages rjson and RJSONIO. Our
  implementation uses an alternative, somewhat more
  consistent mapping between R objects and JSON strings.
  The \code{\link{serializeJSON}} and
  \code{\link{unserializeJSON}} functions use an
  alternative system to convert between R objects and JSON,
  which supports more classes but is much more verbose.
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
}
\author{
  Jeroen Ooms \email{jeroen.ooms@stat.ucla.edu}
}
\references{
  \url{http://www.jsonlint.org}
}

