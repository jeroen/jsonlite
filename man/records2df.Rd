\name{records2df}
\alias{records2df}
\title{Convert a list of records into a dataframe}
\usage{
  records2df(recordlist, columns, flatten = TRUE)
}
\arguments{
  \item{recordlist}{a list of lists representing records
  (rows)}

  \item{columns}{optional. Character vector of the names of
  the fields to extract.}

  \item{flatten}{if records should be unlisted.}
}
\value{
  dataframe
}
\description{
  A helper function to convert a list with records into a
  dataframe.
}
\examples{
myjson <- toJSON(cars)
myrecords <- fromJSON(myjson)
records2df(myrecords);
}

