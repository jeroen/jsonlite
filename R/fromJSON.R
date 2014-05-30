#' These functions are used to convert between \code{JSON} data and \R{} objects. The \code{\link{toJSON}} and \code{\link{fromJSON}}
#' functions use a class based mapping, whichs follows conventions outlined in the vignette of the package.
#' 
#' The \code{\link{toJSON}} and \code{\link{fromJSON}} functions are drop-in replacements for the identically named functions
#' in packages \code{rjson} and \code{RJSONIO}. Our implementation uses an alternative, somewhat more consistent mapping
#' between \R{} objects and \code{JSON} strings. 
#' 
#' The \code{\link{serializeJSON}} and \code{\link{unserializeJSON}} functions in this package use an 
#' alternative system to convert between \R{} objects and \code{JSON}, which supports more classes but is much more verbose.
# 
#' @rdname fromJSON
#' @title Convert \R{} objects to/from \code{JSON}
#' @name toJSON, fromJSON
#' @aliases fromJSON toJSON 
#' @export fromJSON toJSON
#' @param x the object to be encoded
#' @param dataframe how to encode data.frame objects: must be one of 'row' or 'column'
#' @param matrix should matrices and higher dimensional arrays be encoded in row-major or column-major.
#' @param Date how to encode Date objects: must be one of 'ISO8601' or 'epoch'
#' @param POSIXt how to encode POSIXt (datetime) objects: must be one of 'string', 'ISO8601', 'epoch' or 'mongo'
#' @param factor how to encode factor objects: must be one of 'string' or 'integer'
#' @param complex how to encode complex numbers: must be one of 'string' or 'list'
#' @param raw how to encode raw objects: must be one of 'base64', 'hex' or 'mongo'
#' @param auto_unbox automatically \code{\link{unbox}} all atomic vectors of length 1. Not recommended!
#' @param digits max number of digits (after the dot) to print for numeric values
#' @param na how to print NA values. One of 'null' or 'string'. Defaults are class specific
#' @param force unclass/skip objects of classes with no defined json mapping
#' @param pretty adds indentation whitespace to \code{JSON} output. See \code{\link{prettify}}
#' @param txt a string in json format 
#' @param simplifyVector coerse \code{JSON} arrays containing only scalars into a vector
#' @param simplifyDataFrame coerse \code{JSON} arrays containing only records (\code{JSON} objects) into a data frame.
#' @param simplifyMatrix coerse \code{JSON} arrays containing vectors of equal length and mode into matrix or array.
#' @param flatten flatten nested data frames into a single non-nested data frame
#' @param ... arguments passed on to class specific \code{print} methods
#' @useDynLib jsonlite
#' @references Jeroen Ooms (2014). The \code{jsonlite} Package: A Practical and Consistent Mapping Between \code{JSON} Data and \R{} Objects. \emph{arXiv:1403.2805}. \url{http://arxiv.org/abs/1403.2805}
#' @examples #stringify some data
#' jsoncars <- toJSON(mtcars, pretty=TRUE)
#' cat(jsoncars)
#' 
#' #parse it back
#' fromJSON(jsoncars)
#' 
#' #control scientific notation
#' toJSON(10 ^ (0:10), digits=8)
#' options(scipen=3)
#' toJSON(10 ^ (0:10), digits=8)
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
#' #flatten instead:
#' data3 <- fromJSON("https://api.github.com/users/hadley/repos", flatten=TRUE)
#' names(data3)
#' }
fromJSON <- function(txt, simplifyVector = TRUE, simplifyDataFrame = simplifyVector, 
  simplifyMatrix = simplifyVector, flatten = FALSE, ...) {
  
  # check type
  if (!is.character(txt)) {
    stop("Argument 'txt' must be a JSON string, URL or path to existing file.")
  }
  
  # overload for URL or path
  if (length(txt) == 1 && nchar(txt) < 1000) {
    if (grepl("^https?://", txt)) {
      tryCatch(getNamespace("httr"), error = function(e) {
        stop("Package httr not found. Please run: install.packages('httr')", 
          call. = FALSE)
      })
      txt <- download(txt)
    } else if (file.exists(txt)) {
      txt <- paste(readLines(txt, warn = FALSE), collapse = "\n")
    }
  }
  
  # collapse
  if (length(txt) > 1) {
    txt <- paste(txt, collapse = "\n")
  }
  
  # simple check
  if (!grepl("^[ \t\r\n]*(\\{|\\[)", txt)) {
    stop("String does not seem to be valid JSON: ", gsub("\\s+"," ",substring(txt, 0, 30)))
  }
  
  # parse JSON
  obj <- parseJSON(txt)
  
  # post processing
  if (any(isTRUE(simplifyVector), isTRUE(simplifyDataFrame), isTRUE(simplifyMatrix))) {
    return(simplify(obj, simplifyVector = simplifyVector, simplifyDataFrame = simplifyDataFrame, 
      simplifyMatrix = simplifyMatrix, flatten = flatten, ...))
  } else {
    return(obj)
  }
} 
