\name{fromJSON}
\alias{fromJSON}
\title{Convert a json string to an R object.}
\usage{
  fromJSON(txt, simplify = NA, encoding = NA)
}
\arguments{
  \item{txt}{a string in json format}

  \item{simplify}{simplify arrays to vectors where
  possible}

  \item{encoding}{specify character encoding (e.g. "UTF8")}
}
\value{
  An R object.
}
\description{
  Convert a json string to an R object.
}

