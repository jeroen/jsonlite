\name{fromBSON}
\alias{fromBSON}
\title{Convert a mongo.bson object to an R object.}
\usage{
fromBSON(b, simplifyVector = TRUE, simplifyDataFrame = simplifyVector,
  simplifyMatrix = simplifyVector, ...)
}
\arguments{
  \item{b}{A \code{mongo.bson} object. Passed to
  \code{mongo.bson.to.list}. See package \code{rmongodb}.}

  \item{simplifyVector}{coerse JSON arrays containing only
  scalars into a vector}

  \item{simplifyDataFrame}{coerse JSON arrays containing
  only records (JSON objects) into a data frame.}

  \item{simplifyMatrix}{coerse JSON arrays containing
  vectors of equal length and mode into matrix or array.}

  \item{...}{arguments passed on to class specific
  \code{print} methods}
}
\description{
This function uses \code{mongo.bson.to.list} from the
\code{rmongodb} package to read a \code{BSON} object, and
then uses \code{jsonlite} the same mapping as for
\code{JSON} objects to convert it into an R object.
}

