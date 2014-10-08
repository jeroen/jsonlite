#' These functions are used to convert between JSON data and \R{} objects. The \code{\link{toJSON}} and \code{\link{fromJSON}}
#' functions use a class based mapping, which follows conventions outlined in this paper:  \url{http://arxiv.org/abs/1403.2805} (also available as vignette).
#'
#' The \code{\link{toJSON}} and \code{\link{fromJSON}} functions are drop-in replacements for the identically named functions
#' in packages \code{rjson} and \code{RJSONIO}. Our implementation uses an alternative, somewhat more consistent mapping
#' between \R{} objects and JSON strings.
#'
#' The \code{\link{serializeJSON}} and \code{\link{unserializeJSON}} functions in this package use an
#' alternative system to convert between \R{} objects and JSON, which supports more classes but is much more verbose.
#'
#' A JSON string is always unicode, using \code{UTF-8} by default, hence there is usually no need to escape any characters.
#' However, the JSON format does support escaping of unicode characters, which are encoded using a backslash followed by
#' a lower case \code{"u"} and 4 hex characters, for example: \code{"Z\\u00FCrich"}. The \code{fromJSON} function
#' will parse such escape sequences but it is usually preferable to encode unicode characters in JSON using native
#' \code{UTF-8} rather than escape sequences.
#
#' @rdname fromJSON
#' @title Convert \R{} objects to/from JSON
#' @name toJSON, fromJSON
#' @aliases View fromJSON toJSON
#' @export View fromJSON toJSON
#' @param txt a JSON string, URL or file
#' @param simplifyVector coerce JSON arrays containing only primitives into an atomic vector
#' @param simplifyDataFrame coerce JSON arrays containing only records (JSON objects) into a data frame
#' @param simplifyMatrix coerce JSON arrays containing vectors of equal mode and dimension into matrix or array
#' @param flatten automatically \code{\link{flatten}} nested data frames into a single non-nested data frame
#' @param x the object to be encoded
#' @param dataframe how to encode data.frame objects: must be one of 'rows' or 'columns'
#' @param matrix how to encode matrices and higher dimensional arrays: must be one of 'rowmajor' or 'columnmajor'.
#' @param Date how to encode Date objects: must be one of 'ISO8601' or 'epoch'
#' @param POSIXt how to encode POSIXt (datetime) objects: must be one of 'string', 'ISO8601', 'epoch' or 'mongo'
#' @param factor how to encode factor objects: must be one of 'string' or 'integer'
#' @param complex how to encode complex numbers: must be one of 'string' or 'list'
#' @param raw how to encode raw objects: must be one of 'base64', 'hex' or 'mongo'
#' @param null how to encode NULL values within a list: must be one of 'null' or 'list'
#' @param na how to print NA values: must be one of 'null' or 'string'. Defaults are class specific
#' @param auto_unbox automatically \code{\link{unbox}} all atomic vectors of length 1. It is usually safer to avoid this and instead use the \code{\link{unbox}} function to unbox individual elements.
#' @param digits max number of digits (after the dot) to print for numeric values. See: \code{\link{round}}
#' @param force unclass/skip objects of classes with no defined JSON mapping
#' @param pretty adds indentation whitespace to JSON output. See \code{\link{prettify}}
#' @param ... arguments passed on to class specific \code{print} methods
#' @references Jeroen Ooms (2014). The \code{jsonlite} Package: A Practical and Consistent Mapping Between JSON Data and \R{} Objects. \emph{arXiv:1403.2805}. \url{http://arxiv.org/abs/1403.2805}
#' @examples #stringify some data
#' jsoncars <- toJSON(mtcars, pretty=TRUE)
#' cat(jsoncars)
#'
#' #parse it back
#' fromJSON(jsoncars)
#'
#' #parsing escaped unicode
#' fromJSON('{"city" : "Z\\u00FCrich"}')
#'
#' \dontrun{
#' # Parse data frame
#' data1 <- fromJSON("https://api.github.com/users/hadley/orgs")
#' names(data1)
#' data1$login
#'
#' #nested data frames:
#' data2 <- fromJSON("https://api.github.com/users/hadley/repos")
#' names(data2)
#' names(data2$owner)
#' data2$owner$login
#'
#' #same data, but now flattened:
#' data3 <- fromJSON("https://api.github.com/users/hadley/repos", flatten=TRUE)
#' names(data3)
#' }
#'
#' #control scientific notation
#' toJSON(10 ^ (0:10))
#' options(scipen=3)
#' toJSON(10 ^ (0:10))
fromJSON <- function(txt, simplifyVector = TRUE, simplifyDataFrame = simplifyVector,
  simplifyMatrix = simplifyVector, flatten = FALSE, ...) {

  # check type
  if (!is.character(txt)) {
    stop("Argument 'txt' must be a JSON string, URL or path to existing file.")
  }

  # overload for URL or path
  if (length(txt) == 1 && nchar(txt) < 1000) {
    if (grepl("^https?://", txt)) {
      loadpkg("httr")
      txt <- download(txt)
    } else if (file.exists(txt)) {
      filename <- txt;
      # With files we can never know for sure the encoding. Lets try UTF8 first.
      txt <- paste(readLines(filename, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
      isvalid <- validate(txt)
      if(!isvalid && grepl("invalid bytes in UTF8", attr(isvalid, "err"), fixed=TRUE, useBytes=TRUE)){
        # Seems like it wasn't UTF8 after all. Fall back on native encoding.
        Encoding(txt) <- "";
      }
    }
  }

  # collapse
  if (length(txt) > 1) {
    txt <- paste(txt, collapse = "\n")
  }

  # call the actual function (with deprecated arguments)
  fromJSON_string(txt = txt, simplifyVector = simplifyVector, simplifyDataFrame = simplifyDataFrame,
    simplifyMatrix = simplifyMatrix, flatten = flatten, ...)
}

fromJSON_string <- function(txt, simplifyVector = TRUE, simplifyDataFrame = simplifyVector,
  simplifyMatrix = simplifyVector, flatten = FALSE, unicode = TRUE, validate = TRUE, ...){

  if(!missing(unicode)){
    message("Argument unicode has been deprecated. YAJL always parses unicode.")
  }

  if(!missing(validate)){
    message("Argument validate has been deprecated. YAJL automatically validates json while parsing.")
  }

  # parse
  obj <- parseJSON(txt)

  # post processing
  if (any(isTRUE(simplifyVector), isTRUE(simplifyDataFrame), isTRUE(simplifyMatrix))) {
    return(simplify(obj, simplifyVector = simplifyVector, simplifyDataFrame = simplifyDataFrame,
      simplifyMatrix = simplifyMatrix, flatten = flatten, ...))
  } else {
    return(obj)
  }
}

