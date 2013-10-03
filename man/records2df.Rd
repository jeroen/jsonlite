\name{records2df}
\alias{records2df}
\title{Convert a list of records to a dataframe}
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
  This little helper function is used to go from a list
  with records, to a dataframe which has a list with
  columns
}

