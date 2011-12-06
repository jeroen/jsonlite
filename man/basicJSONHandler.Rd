\name{basicJSONHandler}
\alias{basicJSONHandler}
\title{Create handler for processing JSON elements from a parser}
\description{
 This function creates a handler object that is used to 
 consume tokens/elements from a JSON parser and combine
 them into R objects.

 This is  slow relative to using C code because  this is done
 in R and also we don't know the length of each object until
 we have consumed all its elements. 
}
\usage{
basicJSONHandler(default.size = 100, simplify = FALSE)
}
\arguments{
  \item{default.size}{the best guess as to the sizes of the different elements. This is used
   for preallocating space for elements}
  \item{simplify}{a logical value indicating whether to simplify arrays
   from lists to vectors if the elements are of compatible types.}
}
\value{
  \item{update}{a function called with a JSON element and used to process that element and add it to the relevant R object}
  \item{value}{a function to retrieve the result after  processing the JSON}
}
%\references{}
\author{
Duncan Temple Lang
}

\seealso{
 \code{\link{fromJSON}} and the handler argument.
}
\examples{
  h = basicJSONHandler()
  x = fromJSON("[1, 2, 3]", h)
  x
  h$value()
}
\keyword{IO}	
\keyword{programming}
