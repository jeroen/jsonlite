\name{isValidJSON}
\alias{isValidJSON}
\alias{isValidJSON,AsIs-method}
\alias{isValidJSON,character-method}
\alias{isValidJSON,connection-method}
\title{Test if JSON content is valid}
\description{
  This function and its methods allows the caller to verify if the
  JSON content is strictly valid.  Even if the content is invalid,
  the parser may still be able to make sense of it or at least
  get it partially correct and yield a result.
  So this function allows the caller to verify that the input is
  legitimate and not just rely on the parser not failing.
}
\usage{
isValidJSON(content, asText = inherits(content, "AsIs"), ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{content}{the JSON input either as a string, the name of a file
    or URL, or a connection object.}
  \item{asText}{a logical value that specifies whether the value in
    \code{content} is actually the JSON content or the name of a file}
  \item{\dots}{additional parameters for the methods}
}
\value{
   A logical value indicating whether the content is valid JSON
   (\code{TRUE})   or invalid (\code{FALSE}).
}
\references{
 libjson
}
\author{
  Duncan Temple Lang.
  Functionality suggested by Jeroen Ooms.
}

\seealso{
  \code{\link{fromJSON}}
}
\examples{
   isValidJSON(I('{"foo" : "bar"}'))

   isValidJSON(I('{foo : "bar"}'))
   isValidJSON('{foo : "bar"}', TRUE)
}
\keyword{programming}
\keyword{IO}

