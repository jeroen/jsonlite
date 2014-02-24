\name{prettify, minify}
\alias{minify}
\alias{prettify}
\alias{prettify, minify}
\title{Prettify or minify a \code{JSON} string}
\usage{
prettify(txt)

minify(txt)
}
\arguments{
  \item{txt}{JSON string}
}
\description{
Prettify adds indentation to a \code{JSON} string; minify
removes all indentation/whitespace.
}
\examples{
myjson <- toJSON(cars)
cat(myjson)
cat(prettify(myjson))
cat(minify(myjson))
}

