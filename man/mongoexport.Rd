\name{mongoexport}
\alias{mongoexport}
\title{Export to mongo}
\usage{
  mongoexport(x, jsonArray = FALSE, ...)
}
\arguments{
  \item{x}{a dataframe}

  \item{jsonArray}{if output should be an array. See
  details.}

  \item{...}{args passed on to asJSON}
}
\value{
  character vector. If jsonArray=TRUE the output will
  always have length 1.
}
\description{
  Exports a dataframe to a format that can be imported with
  'mongoimport'.
}
\details{
  By default mongoimport expects a datafile in which every
  line is a record in the collection. Hence the complete
  output is not valid json itself. Alternatively, if
  jsonArray=TRUE the output will be wrapped into a json
  array. Note that if this is the case, one has to pass
  --jsonArray to mongoimport as well.#'
}

