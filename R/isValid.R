setGeneric("isValidJSON",
           function(content, asText = inherits(content, "AsIs"), ...)
              standardGeneric("isValidJSON"))

setMethod("isValidJSON", "AsIs",
          function(content, asText = inherits(content, "AsIs"), ...) {
             .Call("R_isValidJSON", as.character(content))
           })

setMethod("isValidJSON", "character",
          function(content, asText = inherits(content, "AsIs"), ...) {

              if(!asText) {
                content = I(suppressWarnings(paste(readLines(content), collapse = "\n")))
              } else
                content = I(content)

              isValidJSON(content, asText = TRUE)
           })
  
setMethod("isValidJSON", "connection",
          function(content, asText = inherits(content, "AsIs"), ...) {
             content = I(suppressWarnings(paste(readLines(content), collapse = "\n")))
             isValidJSON(content, asText = TRUE)              
          })
