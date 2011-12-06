emptyNamedList = structure(list(), names = character())

trim =
function (x) 
  gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)

dQuote =
function(x)
  paste('"', x, '"', sep = "")

setGeneric("toJSON",
function(x, container = .level == 1L || length(x) > 1  || length(names(x)) > 0, collapse = "\n", ...,
           .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE)  
  standardGeneric("toJSON"))

setMethod("toJSON", "NULL",
           function(x, container = .level == 1L || length(x) > 1  || length(names(x)) > 0, collapse = "\n", ..., .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE) {
             if(container) "[ null ] " else "null"
           })

setMethod("toJSON", "ANY",
           function(x, container = .level == 1L || length(x) > 1  || length(names(x)) > 0, collapse = "\n", ..., .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE) {

             if(isS4(x)) {
               paste("{", paste(dQuote(slotNames(x)), sapply(slotNames(x), function(id) toJSON(slot(x, id), ..., .na = .na, .escapeEscapes = .escapeEscapes)), sep = ": "),
                     "}", collapse = collapse)
             } else {
               stop("No method for converting ", class(x), " to JSON")
             }
             
           })


setMethod("toJSON", "integer",
           function(x, container = .level == 1L || length(x) > 1 || length(names(x)) > 1, collapse = "\n  ", ..., .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE) {

             if(any(nas <- is.na(x)))
                 x[nas] = .na

             if(container) {
                if(.withNames)
                   paste(sprintf("{%s", collapse), paste(dQuote(names(x)), x, sep = ": ", collapse = sprintf(",%s", collapse)), sprintf("%s}", collapse))
                else
                   paste("[", paste(x, collapse = ", "), "]")
              } else
                 as.character(x)               
           })

setOldClass("hexmode")

setMethod("toJSON", "hexmode",
           function(x, container = .level == 1L || length(x) > 1 || length(names(x)) > 0, collapse = "\n   ", ..., .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE) {

             
             tmp = paste("0x", format(x), sep = "")
             if(any(nas <- is.na(x)))
                 tmp[nas] = .na             
             
             if(container) {
                if(.withNames)
                   paste(sprintf("{%s", collapse), paste(dQuote(names(x)), tmp, sep = ": ", collapse = sprintf(",%s", collapse)), sprintf("%s}", collapse))
                else               
                paste("[", paste(tmp, collapse = ", "), "]")
             } else
                tmp
           })


setMethod("toJSON", "factor",
           function(x, container = .level == 1L || length(x) > 1 || length(names(x)) > 0, collapse = "\n", ..., .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null") {

             toJSON(as.character(x), container, collapse, ..., .level = .level, .na = .na, .escapeEscapes = .escapeEscapes)
           })

setMethod("toJSON", "logical",
           function(x, container = .level == 1L || length(x) > 1 || length(names(x)) > 0, collapse = "\n", ..., .level = 1L, .na = "null") {
             tmp = ifelse(x, "true", "false")
             if(any(nas <- is.na(tmp)))
                 tmp[nas] = .na             

             if(container) {
                if(.withNames)
                   paste(sprintf("{%s", collapse), paste(dQuote(names(x)), tmp, sep = ": ", collapse = sprintf(",%s", collapse)), sprintf("%s}", collapse))
                else               
                   paste("[", paste(tmp, collapse = ", "), "]")
             } else
                tmp
           })

setMethod("toJSON", "numeric",
           function(x, container = .level == 1L || length(x) > 1 || length(names(x)) > 0, collapse = "\n", digits = 5, ..., .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE) {

             tmp = formatC(x, digits = digits)
             if(any(nas <- is.na(x)))
                 tmp[nas] = .na                          
             
             if(container) {
                if(.withNames)
                   paste(sprintf("{%s", collapse), paste(dQuote(names(x)), tmp, sep = ": ", collapse = sprintf(",%s", collapse)),
                                   sprintf("%s}", collapse))
                else
                   paste("[", paste(tmp, collapse = ", "), "]")
             } else
               tmp
           })


setMethod("toJSON", "character",
           function(x, container = .level == 1L || length(x) > 1 || length(names(x)) > 0, collapse = "\n", digits = 5, ..., .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE) {
# Don't do this: !             tmp = gsub("\\\n", "\\\\n", x)
             tmp = x

             tmp = gsub('(\\\\)', '\\1\\1', tmp)
             if(.escapeEscapes) {
               tmp = gsub("\\t", "\\\\t", tmp)
               tmp = gsub("\\n", "\\\\n", tmp)
             }
             tmp = gsub('"', '\\\\"', tmp)
             tmp = dQuote(tmp)

             if(any(nas <- is.na(x)))
                 tmp[nas] = .na                          
             
             if(container) {
                if(.withNames)
                   paste(sprintf("{%s", collapse),
                          paste(dQuote(names(x)), tmp, sep = ": ", collapse = sprintf(",%s", collapse)),
                         sprintf("%s}", collapse))
                else               
                   paste("[", paste(tmp, collapse = ", "), "]")
             } else
                tmp
           })



# Symbols.
# names can't be NA
setMethod("toJSON", "name",
           function(x, container = .level == 1L || length(x) > 1 || length(names(x)) > 0, collapse = "\n", ..., .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE) {
             as.character(x)
           })

setMethod("toJSON", "AsIs",
           function(x, container = length(x) > 1 || length(names(x)) > 0, collapse = "\n", ..., .level=1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE) {
              toJSON(structure(x, class = class(x)[-1]), container = TRUE, collapse = collapse, ..., .level = .level + 1L, .withNames = .withNames, .na = .na, .escapeEscapes = .escapeEscapes)
           })



setMethod("toJSON", "matrix",
           function(x, container = length(x) > 1 || length(names(x)) > 0, collapse = "\n", ...,
                    .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE) {
             tmp = paste(apply(x, 1, toJSON, .na = .na, ..., .escapeEscapes = .escapeEscapes), collapse = sprintf(",%s", collapse))
             if(!container)
               return(tmp)

              if(.withNames)
                paste("{", paste(dQuote(names(x)), tmp, sep = ": "), "}")                
              else
                paste("[", tmp, "]")
           })

setMethod("toJSON", "list",
           function(x, container = is.list(x) || .level == 1L || length(x) > 1 || length(names(x)) > 0, collapse = "\n", ..., .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE) {
                # Degenerate case.
             if(length(x) == 0) {
                          # x = structure(list(), names = character()) gives {}
                return(if(is.null(names(x))) "[]" else "{}")
             }

             els = lapply(x, toJSON, ..., .level = .level + 1L, .na = .na, .escapeEscapes = .escapeEscapes)

             if(all(sapply(els, is.name)))
               names(els) = NULL

             if(!container)
               return(els)
             
             if(.withNames)
                paste(sprintf("{%s", collapse),
                      paste(dQuote(names(x)), els, sep = ": ", collapse = sprintf(",%s", collapse)),
                      sprintf("%s}", collapse))
             else
                 paste(sprintf("[%s", collapse), paste(els, collapse = sprintf(",%s", collapse)), sprintf("%s]", collapse))
           })
