\name{readJSONStream}
\alias{readJSONStream}
\title{Read JSON from a Connection/Stream}
\description{
  This function is  capable of reading and processing
  JSON content from a "stream".  This is most likely
  to be from an R  connection, but can be an arbitrary
  source of JSON content.
  The idea is that the parser will pull partial data from the
  source and process it immediately, and then return to
  retrieve more data.  This allows the parser to work on
  the JSON content without it all being in memory at one
  time. This can save a significant amount of memory
  and make some computations feasible which would not
  be if we had to first read all of the JSON and then
  process it.
}
\usage{
readJSONStream(con, cb = NULL, simplify = Strict, nullValue = NULL,
                 simplifyWithNames = TRUE)
}
\arguments{
  \item{con}{a connection object from which we will read the JSON
    content.  This can also be any R expression       that returns
    a string. This allows a caller to get content from any source,
    not just a connection.
}
  \item{cb}{
    an optional callback function that is invoked
    for each top-level JSON object in the stream.  Typically there
    will only be one  such top-level object and so the callback
    is not really needed as the default is to return that top-level
    object from \code{readJSONStream}.
    However, if there are multiple top-level JSON objects in the stream,
    this callback function can process them, e.g. merge them, collapse
    the contents.
  }
  \item{simplify}{same as for \code{\link{fromJSON}}.}
  \item{nullValue}{same as for \code{\link{fromJSON}}.}  
  \item{simplifyWithNames}{same as for \code{\link{fromJSON}}.}  
}
\value{
 By default, this returns the top-level JSON object in the stream.
}
\references{
  libjson and the \code{JSONSTREAM} facilities.
}
\author{Duncan Temple Lang}

\seealso{
  \code{\link{fromJSON}} and its methods,
  specifically the method for a connection.
}
\examples{
xx = '[1,2, 3]{"a": [true, false]}'
con = textConnection(xx)

f = function(x)
       print(sum(unlist(x)))

readJSONStream(con, f)

  # The callback function can be anonymous
con = textConnection(xx)
readJSONStream(con, function(x)
                       print(sum(unlist(x))))



gen = 
function() {
 ans <- 0
 list(update = function(x) ans <<- ans + sum(unlist(x)),
      value = function() ans)
}
g = gen()
con = textConnection(xx)
readJSONStream(con, g$update)

}
\keyword{IO}

