\name{fromJSON}
\alias{fromJSON}
\alias{fromJSON,character,ANY-method}
\alias{fromJSON,connection,ANY-method}
\alias{fromJSON,AsIs,ANY-method}
\alias{fromJSON,AsIs,JSONParserHandler-method}
\alias{fromJSON,AsIs,NULL-method}
\alias{fromJSON,AsIs,function-method}
\alias{fromJSON,AsIs,NativeSymbolInfo-method}

\alias{Strict}
\alias{StrictNumeric}
\alias{StrictCharacter}
\alias{StrictLogical}

\title{Convert JSON content to R objects}
\description{
  This function and its methods read content in JSON format
  and de-serializes it into R objects.
  JSON content is made up of logicals, integers, real numbers, strings,
  arrays of these and associative arrays/hash tables using \code{key:
    value} pairs.
  These map very naturally to R data types (logical, integer, numeric,
  character,  and named lists).
}
\usage{
fromJSON(content, handler = NULL,
          default.size = 100, depth = 150L, allowComments = TRUE,
           asText = isContent(content), data = NULL,
            maxChar = c(0L, nchar(content)), simplify = Strict,
             nullValue = NULL, simplifyWithNames = TRUE,
              encoding = NA_character_, ...)
}

\arguments{
  \item{content}{the JSON content. This can be the name of a file
    or the content itself as a character string.
     We will add support for connections in the near future.
   }
   \item{handler}{an R object that is responsible for processing
     each individual token/element within the JSON content.
     By default, this is \code{NULL} and we use the fast libjson parsing approach.
     Unless you want to customize the processing of the nodes in the tree, use
     \code{NULL}.
     This can be an R function, a list of functions with class
     \code{"JSONParserHandler"} having  \code{update} and \code{value}
     elements, or the address of a native (C) routine.
     In the case of the latter, the \code{data} parameter can be used
     to specify an object that is passed to the C routine each time it
     is called.  This will commonly be an \code{externalptr} object.
   }
  \item{default.size}{a number giving the default buffer size to use for
    arrays and objects in an effort to avoid reallocating each time we
    add a new element.}
  \item{depth}{the maximum number of nested JSON levels, i.e. arrays and
      objects within arrays and objects. }
    \item{allowComments}{a logical value indicating whether to allow
      C-style comments within the JSON content or to raise an error if
     they are encountered.}
   \item{asText}{a logical value indicating whether the value of the \code{content}
     argument should be treated as the JSON content, i.e. read directly
     rather than considered the name of a file.}
   \item{data}{a value that is only used when the value of
     \code{handler} is a native (C) routine.
     In this case, the value is passed in each call to that C routine
     by the JSON tokenizer.
   }
   \item{maxChar}{an integer vector of length 2 giving the start and end
     offsets in the character string to be processed. This allows the
    caller to specify a subset of the string to process without explicitly
    having to make a copy of the substring. }
   \item{simplify}{either a logical value or a number, e.g. the value of the variable \code{Strict} (the
  default).  This  controls whether we attempt to
  collapse collections/arrays of homogeneous scalar elements to R
  vectors.
  If this is \code{FALSE}, no effort to combine scalars is made and they
  remain as separate list elements.
  If this is \code{TRUE}, then logicals, numbers and strings are
  collapsed to their common types in the same manner as \code{c}.
  The value  \code{Strict} does attempt to collapse collections of
  scalars but only if they are all of the same type, i.e. all strings,
  all numbers or all logicals.
  If we want to collapse numbers, but not logicals or characters,
  we can use \code{StrictNumeric}. Similarly, to collapse
  logicals but not numeric or character collections, we use
  \code{StrictLogical}. And, to collapse only character collections,
  we use \code{StrictCharacter}. If we want to collapse two types
  but not a third, we add the two values, e.g.
  \code{StrictLogical + StrictNumeric}, or
  pass them as a vector \code{c(StrictLogical, StrictNumeric)}.
  \code{Strict} is merely the combination of all 3 of the individual
  strict variables.
  %
  Currently this is only implemented when the caller does not provide
  a handler and in the C code.
   }
   \item{nullValue}{an R value that is used when we encounter
     a JSON \code{null} value in the JSON content.
     This can be used to map \code{null} to something more R-like
     such as \code{NA}.  This can be an arbitrary R object.
   }
   \item{simplifyWithNames}{ a logical value that controls whether we
  attempt to collapse collections if the elements have names in the JSON
   content, i.e. a dictionary/associative array.  If this is
  \code{TRUE}, then we consider collapsing according to the value of
  \code{simplify}.  If this is \code{FALSE}, if the collection has
  names, we do not attempt to simplify.
}
  \item{encoding}{the encoding for the content. This is used to ensure
  the encoding of any resulting strings/character vectors have this
  encoding.
  The default for this value is to use the same encoding as the input content.}
   \item{\dots}{additional parameters for methods.}
  \item{stringFun}{an R function or a compiled routine (by address or name).
    The purpose of this is to process every string as it is encountered in the 
   JSON content and to either convert return it as-is, or to convert it to 
    a suitable R value.  This, for example, might convert strings of the form
    "/new Date(2313213)/" or "/Date(12312312)/".  
   The result is placed in the 
   R object being generated from the JSON content where the original string would appear.
   So this allows us to handle strings with a special meaning.

   If this is an R function, it is passed a single argument - the value of the string - and it can return that or
   any other R object, presumably derived from that original string. 
   If a compiled routine is specified, it can be one of two types. 
   Both take a simple C string.  
   The default type returns a \code{SEXP}, i.e. an R object.
   If the class of \code{stringFun} is either \code{AsIs} or \code{NativeStringRoutine},
   then that routine must return a C string.
  }
}

\value{
  An R object created by mapping the JSON content
  to its R equivalent.
}
\references{
  \url{http://www.json.org}
}
\author{Duncan Temple Lang <duncan@wald.ucdavis.edu}

\seealso{
  \code{\link{toJSON}}
  the non-exported collector function
  \code{{RJSONIO:::basicJSONHandler}}.  
}
\examples{

  fromJSON(I(toJSON(1:10)))

  fromJSON(I(toJSON(1:10 + .5)))

  fromJSON(I(toJSON(c(TRUE, FALSE, FALSE, TRUE))))

  x = fromJSON('{"ok":true,"id":"x123","rev":"1-1794908527"}')


   # Reading from a connection. It is a text connection so we could
   # just read the text directly, but this could be a dynamic connection.
  m = matrix(1:27, 9, 3)
  txt = toJSON(m)
  con = textConnection(txt)
  identical(m, fromJSON(con))

    # Use a connection and move the cursor ahead to skip over some lines.
  f = system.file("sampleData", "obj1.json", package = "RJSONIO")
  con = file(f, "r")
  readLines(con, 1)
  fromJSON(con)
  close(con)


  f = system.file("sampleData", "embedded.json", package = "RJSONIO")
  con = file(f, "r")
  readLines(con, 1)  # eat the first line
  fromJSON(con, maxNumLines = 4)
  close(con)

\dontrun{
if(require(rjson)) {
    # We see an approximately a factor of 3.9 speed up when we use
    # this approach that mixes C-level tokenization and an R callback
    # function to gather the results into objects.
    
  f = system.file("sampleData", "usaPolygons.as", package = "RJSONIO")
  t1 = system.time(a <- RJSONIO:::fromJSON(f))
  t2 = system.time(b <- fromJSON(paste(readLines(f), collapse = "\n")))
}
}
    # Use a C routine
  fromJSON(I("[1, 2, 3, 4]"),
           getNativeSymbolInfo("R_json_testNativeCallback", "RJSONIO"))

    # Use a C routine that populates an R integer vector with the
    # elements read from the JSON array. Note that we must ensure
    # that the array is big enough.
  fromJSON(I("[1, 2, 3, 4]"),
           getNativeSymbolInfo("R_json_IntegerArrayCallback", PACKAGE = "RJSONIO"),
           data = rep(1L, 5))

  x = fromJSON(I("[1.1, 2.2, 3.3, 4.4]"),
               getNativeSymbolInfo("R_json_RealArrayCallback", PACKAGE = "RJSONIO"),
                data = rep(1, 5))
  length(x) = 4


    # This illustrates a "specialized" handler which knows what it is
    #  expecting and pre-allocates the answer
    # This then populates the answer with the values.
    # The speed improvement is 1.8 versus "infinity"!

  x = rnorm(1000000)
  str = toJSON(x, digits = 6)
  
  fromJSON(I(str),
           getNativeSymbolInfo("R_json_RealArrayCallback", PACKAGE = "RJSONIO"),
           data = numeric(length(x)))


    # This is another example of very fast reading of specific JSON.
  x = matrix(rnorm(1000000), 1000, 1000)
  str = toJSON(x, digits = 6)
  
  v = fromJSON(I(str),
           getNativeSymbolInfo("R_json_RealArrayCallback", PACKAGE = "RJSONIO"),
           data = matrix(0, 1000, 1000))


    # nulls and NAs
  fromJSON("{ 'abc': 1, 'def': 23, 'xyz': null, 'ooo': 4}", nullValue = NA)
  fromJSON("{ 'abc': 1, 'def': 23, 'xyz': null, 'ooo': 4}", nullValue =  NULL) # default

  fromJSON("[1, 2, 3, null, 4]", nullValue = NA)
  fromJSON("[1, 2, 3, null, 4]", nullValue = NULL)


   # we can supply a complex object for null if we ever should need to.
  fromJSON('[ 1, 2, null]', nullValue = list(a = 1, b = 1:10))[[3]]


  # Using StrictNumeric, etc.
  x = list(sub1 = list(a = 1:10, b = 100, c = 1000),
           sub2 = list(animal1 = "ape", animal2 = "bear", animal3 = "cat"),
           sub3 = rep(c(TRUE, FALSE), 3))
  js = toJSON(x)

  fromJSON(js)
    # leave character strings uncollapsed
  fromJSON(js, simplify = StrictNumeric + StrictLogical)
  fromJSON(js, simplify = c(StrictNumeric, StrictLogical))


  fromJSON(js, simplifyWithNames = FALSE)
  fromJSON(js, simplifyWithNames = TRUE)
}
\keyword{IO}
\keyword{programming}

