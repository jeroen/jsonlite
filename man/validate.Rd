\name{validate}
\alias{validate}
\title{Validate JSON}
\usage{
  validate(txt)
}
\arguments{
  \item{txt}{JSON string}
}
\description{
  Test if a string is a valid JSON string. Characters
  vectors will be collapsed into a single string.
}
\examples{
#Output from toJSON and serializeJSON should pass validation
myjson <- toJSON(mtcars)
validate(myjson) #TRUE

#Something bad happened
truncated <- substring(myjson, 1, 100)
validate(truncated) #FALSE
}

