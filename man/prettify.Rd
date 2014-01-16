\name{minify}
\alias{minify}
\alias{prettify}
\title{prettify, minify}
\usage{
  minify(txt)

  prettify(txt)
}
\arguments{
  \item{txt}{JSON string}
}
\description{
  Prettify or minify a JSON string.
}
\details{
  Prettify adds indentation to a JSON string; minify
  removes all indentation/whitespace.
}
\examples{
myjson <- toJSON(cars)
cat(myjson)
cat(prettify(myjson))
cat(minify(myjson))
}

