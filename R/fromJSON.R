#' Stringify R objects to JSON and vice versa
#' 
#' These functions are used to convert R objects into JSON and back. The \code{\link{toJSON}} and \code{\link{fromJSON}}
#' functions use a class based encoding schema which follows conventions outlines in the vignette of this 
#' package. They implement a consitent and practical mapping between JSON structures and the standard data 
#' structures in R. 
#' 
#' The \code{\link{toJSON}} and \code{\link{fromJSON}} functions are drop-in replacements for the identically named functions
#' in packages rjson and RJSONIO. Our implementation uses an alternative, somewhat more consistent mapping
#' between R objects and JSON strings. The \code{\link{serializeJSON}} and \code{\link{unserializeJSON}} functions use an 
#' alternative system to convert between R objects and JSON, which supports more classes but is much more verbose.
# 
#' @export fromJSON
#' @export toJSON
#' @useDynLib jsonlite
#' @name toJSON
#' @aliases fromJSON
#' @param x the object to be encoded
#' @param dataframe how to encode data.frame objects: must be one of 'row' or 'column'
#' @param matrix should matrices and higher dimensional arrays be encoded in row-major or column-major.
#' @param Date how to encode Date objects: must be one of 'ISO8601' or 'epoch'
#' @param POSIXt how to encode POSIXt (datetime) objects: must be one of 'string', 'ISO8601', 'epoch' or 'mongo'
#' @param factor how to encode factor objects: must be one of 'string' or 'integer'
#' @param complex how to encode complex numbers: must be one of 'string' or 'list'
#' @param raw how to encode raw objects: must be one of 'base64', 'hex' or 'mongo'
#' @param digits max number of digits (after the dot) to print for numeric values
#' @param na how to print NA values. One of 'null' or 'string'. Defaults are class specific
#' @param pretty adds indentation whitespace to JSON output. See \code{\link{prettify}}
#' @param txt a string in json format 
#' @param simplifyVector coerse JSON arrays containing only scalars into a vector
#' @param simplifyDataFrame coerse JSON arrays containing only records (JSON objects) into a data frame.
#' @param simplifyMatrix coerse JSON arrays containing vectors of equal length and mode into matrix or array.
#' @param ... arguments passed on to class specific \code{print} methods
#' @note All encoded objects should pass the validation at www.jsonlint.org
#' @references
#' \url{http://www.jsonlint.org}
#' @author Jeroen Ooms \email{jeroen.ooms@@stat.ucla.edu}
#' @rdname toJSON
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
#' }
fromJSON <- function(txt, simplifyVector = TRUE, simplifyDataFrame = simplifyVector, 
  simplifyMatrix = simplifyVector, ...) {
  
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
      req <- httr::GET(txt, httr::config(httpheader=c(`User-Agent` = "RCurl-httr-jsonlite"), 
        sslversion = 3, ssl.verifypeer=FALSE, ssl.verifyhost = FALSE))
      httr::stop_for_status(req)
      txt <- rawToChar(req$content)
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
    stop("String does not seem to be valid JSON: ", substring(txt, 0, 20))
  }
  
  # parse JSON
  obj <- parseJSON(txt)
  
  # post processing
  if (any(isTRUE(simplifyVector), isTRUE(simplifyDataFrame), isTRUE(simplifyMatrix))) {
    return(simplify(obj, simplifyVector = simplifyVector, simplifyDataFrame = simplifyDataFrame, 
      simplifyMatrix = simplifyMatrix, ...))
  } else {
    return(obj)
  }
} 
