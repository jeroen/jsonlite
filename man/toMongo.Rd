\name{toMongo}
\alias{toMongo}
\title{Export to MongoDB}
\usage{
  toMongo(x, array = FALSE, ...)
}
\arguments{
  \item{x}{a dataframe}

  \item{array}{if output should be an array. See details.}

  \item{...}{args passed on to asJSON}
}
\description{
  Exports a dataframe to a format that can be imported with
  'mongoimport'.
}
\details{
  By default mongoimport expects a datafile in which every
  line is a record in the collection. Hence the complete
  output is not valid json itself. Alternatively, if
  array=TRUE the output will be wrapped a JSON array. When
  using the latter, we need to pass --jsonArray to
  mongoimport.
}

