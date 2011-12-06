\name{Bob}
%\Rdversion{1.1}
\alias{JSON_T_ARRAY_BEGIN}
\alias{JSON_T_ARRAY_END}
\alias{JSON_T_FALSE}
\alias{JSON_T_FLOAT}
\alias{JSON_T_INTEGER}
\alias{JSON_T_KEY}
\alias{JSON_T_MAX}
\alias{JSON_T_NONE}
\alias{JSON_T_NULL}
\alias{JSON_T_OBJECT_BEGIN}
\alias{JSON_T_OBJECT_END}
\alias{JSON_T_STRING}
\alias{JSON_T_TRUE}
\docType{data}
\title{
 Symbolic constants identifying the type of a JSON value.
}
\description{
These constants are used by handler functions that
are called when a JSON value is encountered by the 
JSON parser. These identify the type of the JSON value.
The values will already have been converted, but
the start and end array and object events won't have
a type.
}
%\usage{}
\format{
  A collection of integer values.
}
\source{
 \code{JSON_parser.h} code from \url{http://www.json.org}. 
}
\references{
 \url{http://www.json.org}. 
}
%\examples{}
\keyword{datasets}
