\name{asJSVars}
\alias{asJSVars}
\title{Serialize R objects as Javsscript/ActionScript variables}
\description{
  This function takes R objects and serializes them as
  Javascript/ActionScript values.
  It uses the specified names in the R call as
  Javascript variable names. One can also specify
  qualifiers (\sQuote{public}, \sQuote{protected}, \sQuote{private})
  and also types. These are optional, but useful, in ActionScript.
}
\usage{
asJSVars(..., .vars = list(...), qualifier = character(), types = character())
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{\dots}{\code{name = value} pairs where the \code{value} is an R object
    that is converted to JSON format and \code{name} is the name of the corresponding
    Javascript variable.}
  \item{.vars}{this is an alternative to \dots as a way to specify a collection of
    \code{name = value} pairs that is already in a list.}
  \item{qualifier}{a character vector (recycled as necessary) which is
    used as qualifiers for the individual ActionScript variables.
     The values should be public, protected or private.
   }
  \item{types}{either a logical value or a character vector (which is
    recycled if necessary). If this is \code{TRUE}, then we compute the
    Javascript type for each of the R objects (using the non-exported
    function \code{jsType})}
}
\value{
  A character vector of length 1 giving the variable declarations and
  initializations.
}
\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}

\seealso{
 \code{\link{toJSON}}  
}
\examples{
 cat(asJSVars( a =  1:10, myMatrix = matrix(1:15, 3, 5)))
 cat(asJSVars( a =  1:10, myMatrix = matrix(1:15, 3, 5), types = TRUE))
 cat(asJSVars( a =  1:10, myMatrix = matrix(1:15, 3, 5),
        qualifier = "protected", types = TRUE))
}
\keyword{IO}
\keyword{programming}

