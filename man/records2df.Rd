\name{records2df}
\alias{records2df}
\title{Convert a list of records into a dataframe}
\usage{
  records2df(recordlist, columns, flatten = TRUE)
}
\arguments{
  \item{recordlist}{a list of lists representing records
  (rows).}

  \item{columns}{optional. Character vector of the names of
  the fields to extract.}

  \item{flatten}{if records should be unlisted in the case
  of nested lists.}
}
\value{
  dataframe
}
\description{
  A helper function to convert a list with records into a
  dataframe.
}
\details{
  Data frames in R are colum based, but most data sets in
  JSON are provided in a row-based format; i.e. an array of
  key-value pairs. For example
  \url{https://api.github.com/users/hadley/repos}. This
  function converts a collection of records into a data
  frame. The input is a list of lists, as it would be
  returned by \code{fromJSON} without any simplification.

  The \code{column} argument is a vector specifying which
  fields (list elements) need to be extracted and turned
  data frame columns. If this argument is not specified,
  each unique field appearing in any of the records will
  used. Note that this can lead to very large data frames
  with lots of \code{NA} values when the data contains
  different fields for each record.

  Finally, something that is common in the case of JSON
  datasets is that records have again lists nested in them.
  The \code{flatten} argument can be used to control how to
  deal with these cases. When set to \code{TRUE}, they will
  be unlisted and turn into several columns.
}
\examples{
myjson <- toJSON(cars)
myrecords <- fromJSON(myjson)
records2df(myrecords);
}

