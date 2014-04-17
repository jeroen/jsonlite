\name{toJSON, fromJSON}
\alias{fromJSON}
\alias{toJSON}
\alias{toJSON, fromJSON}
\title{Convert R objects to/from \code{JSON}}
\usage{
fromJSON(txt, simplifyVector = TRUE, simplifyDataFrame = simplifyVector,
  simplifyMatrix = simplifyVector, flatten = FALSE, ...)

toJSON(x, dataframe = c("rows", "columns"), matrix = c("rowmajor",
  "columnmajor"), Date = c("ISO8601", "epoch"), POSIXt = c("string",
  "ISO8601", "epoch", "mongo"), factor = c("string", "integer"),
  complex = c("string", "list"), raw = c("base64", "hex", "mongo"),
  na = c("null", "string"), auto_unbox = FALSE, digits = 2,
  pretty = FALSE, force = FALSE, ...)
}
\arguments{
  \item{x}{the object to be encoded}

  \item{dataframe}{how to encode data.frame objects: must
  be one of 'row' or 'column'}

  \item{matrix}{should matrices and higher dimensional
  arrays be encoded in row-major or column-major.}

  \item{Date}{how to encode Date objects: must be one of
  'ISO8601' or 'epoch'}

  \item{POSIXt}{how to encode POSIXt (datetime) objects:
  must be one of 'string', 'ISO8601', 'epoch' or 'mongo'}

  \item{factor}{how to encode factor objects: must be one
  of 'string' or 'integer'}

  \item{complex}{how to encode complex numbers: must be one
  of 'string' or 'list'}

  \item{raw}{how to encode raw objects: must be one of
  'base64', 'hex' or 'mongo'}

  \item{auto_unbox}{automatically \code{\link{unbox}} all
  atomic vectors of length 1. Not recommended!}

  \item{digits}{max number of digits (after the dot) to
  print for numeric values}

  \item{na}{how to print NA values. One of 'null' or
  'string'. Defaults are class specific}

  \item{force}{unclass/skip objects of classes with no
  defined json mapping}

  \item{pretty}{adds indentation whitespace to JSON output.
  See \code{\link{prettify}}}

  \item{txt}{a string in json format}

  \item{simplifyVector}{coerse JSON arrays containing only
  scalars into a vector}

  \item{simplifyDataFrame}{coerse JSON arrays containing
  only records (JSON objects) into a data frame.}

  \item{simplifyMatrix}{coerse JSON arrays containing
  vectors of equal length and mode into matrix or array.}

  \item{flatten}{flatten nested data frames into a single
  non-nested data frame}

  \item{...}{arguments passed on to class specific
  \code{print} methods}
}
\description{
These functions are used to convert R objects into JSON and
vice versa. The \code{\link{toJSON}} and
\code{\link{fromJSON}} functions use a class based encoding
schema which follows conventions outlines in the vignette
of this package. They implement a consitent and practical
mapping between JSON structures and the standard data
structures in R.
}
\details{
The \code{\link{toJSON}} and \code{\link{fromJSON}}
functions are drop-in replacements for the identically
named functions in packages rjson and RJSONIO. Our
implementation uses an alternative, somewhat more
consistent mapping between R objects and JSON strings. The
\code{\link{serializeJSON}} and
\code{\link{unserializeJSON}} functions use an alternative
system to convert between R objects and JSON, which
supports more classes but is much more verbose.
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

#control scientific notation
toJSON(10 ^ (0:10), digits=8)
options(scipen=3)
toJSON(10 ^ (0:10), digits=8)

\dontrun{
# Parse data frame
data1 <- fromJSON("https://api.github.com/users/hadley/orgs")
names(data1)
data1$login

#nested data frames:
data2 <- fromJSON("https://api.github.com/users/hadley/repos")
names(data2)
names(data2$owner)
data2$owner$login
}
}
\author{
Jeroen Ooms \email{jeroen.ooms@stat.ucla.edu}
}
\references{
\url{http://www.jsonlint.org}
}

