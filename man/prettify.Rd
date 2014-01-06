\name{prettify}
\alias{prettify}
\title{Prettify JSON}
\usage{
  prettify(txt)
}
\arguments{
  \item{txt}{JSON string}
}
\description{
  Add proper whitespace and indentation to a JSON string.
}
\examples{
myjson <- toJSON(cars, pretty=FALSE)
myprettyjson <- prettify(myjson)
cat(myprettyjson)
}
\seealso{
  Other prettify: \code{\link{minify}}
}

