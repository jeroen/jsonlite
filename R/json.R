emptyNamedList = structure(list(), names = character())

trim =
function (x) 
  gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)

dQuote =
function(x)
  paste('"', x, '"', sep = "")

isContainer =
function(x, asIs, .level)
  (is.na(asIs) && .level == 1) || (!is.na(asIs) && asIs) ||
       .level == 1L || length(x) > 1  || length(names(x)) > 0 || is.list(x)

setGeneric("toJSON",
  function(x, container = isContainer(x, asIs, .level),
           collapse = "\n", ...,
           .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0,
            .na = "null", .escapeEscapes = TRUE, pretty = FALSE, asIs = NA)   {

  container; .withNames  # force these values.
  
  ans <- standardGeneric("toJSON")

  if(pretty)
     jsonPretty(ans)
  else
     ans
  })



setMethod("toJSON", "NULL",
           function(x, container = isContainer(x, asIs, .level), collapse = "\n", ...,
                     .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null",
                      .escapeEscapes = TRUE, pretty = FALSE, asIs = NA) {
             if(container) "[ null ] " else "null"
           })


setMethod("toJSON", "ANY",
           function(x, container =  isContainer(x, asIs, .level), collapse = "\n", ...,
                       .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0,
                      .na = "null", .escapeEscapes = TRUE, pretty = FALSE, asIs = NA) {

             if(isS4(x)) {
               paste("{", paste(dQuote(slotNames(x)), sapply(slotNames(x),
                                                              function(id)
                                                                 toJSON(slot(x, id), ..., .level = .level + 1L,
                                                                        .na = .na, .escapeEscapes = .escapeEscapes, asIs = asIs)),
                                 sep = ": ", collapse = ","),
                     "}", collapse = collapse)
             } else {
#cat(class(x), "\n")
               if(is.language(x)) {
                  return(toJSON(as.list(x), asIs = asIs))
                  stop("No method for converting ", class(x), " to JSON")
               }

               toJSON(unclass(x), container, collapse, ..., .level = .level + 1L,
                         .withNames = .withNames, .na = .na, .escapeEscapes = .escapeEscapes, asIs = asIs)
               # stop("No method for converting ", class(x), " to JSON")
             }
             
           })



setMethod("toJSON", "integer",
           function(x, container =  isContainer(x, asIs, .level),
                      collapse = "\n  ", ..., .level = 1L,
                      .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null",
                       .escapeEscapes = TRUE, pretty = FALSE, asIs = NA) {

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
           function(x, container =  isContainer(x, asIs, .level), collapse = "\n   ", ...,
                     .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0,
                       .na = "null", .escapeEscapes = TRUE, pretty = FALSE, asIs = NA) {

             
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
           function(x, container =  isContainer(x, asIs, .level),
                     collapse = "\n", ..., .level = 1L,
                     .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", pretty = FALSE, asIs = NA) {

             toJSON(as.character(x), container, collapse, ..., .level = .level, .na = .na, .escapeEscapes = .escapeEscapes, asIs = asIs)
           })

setMethod("toJSON", "logical",
           function(x, container =  isContainer(x, asIs, .level),
                     collapse = "\n", ..., .level = 1L,
                     .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", pretty = FALSE, asIs = NA) {
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
           function(x, container =  isContainer(x, asIs, .level), collapse = "\n", digits = 5, ...,
                      .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0,
                        .na = "null", .escapeEscapes = TRUE, pretty = FALSE, asIs = NA) {

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
           function(x, container =  isContainer(x, asIs, .level), collapse = "\n", digits = 5, ..., .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE, pretty = FALSE, asIs = NA) {
# Don't do this: !             tmp = gsub("\\\n", "\\\\n", x)

#             if(length(x) == 0)    return("[ ]")
             
             tmp = x

             tmp = gsub('(\\\\)', '\\1\\1', tmp)
             if(.escapeEscapes) {
               tmp = gsub("\\t", "\\\\t", tmp)
               tmp = gsub("\\n", "\\\\n", tmp)
               tmp = gsub("\b", "\\\\b", tmp)               
               tmp = gsub("\\r", "\\\\r", tmp)
               tmp = gsub("\\f", "\\\\f", tmp)                              
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
           function(x, container =  isContainer(x, asIs, .level), collapse = "\n", ..., .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE, pretty = FALSE, asIs = NA) {
             as.character(x)
           })

setMethod("toJSON", "name",
           function(x, container =  isContainer(x, asIs, .level), collapse = "\n", ..., .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE, pretty = FALSE, asIs = NA) {
             
               sprintf('"%s"', as.character(x))
           })


setOldClass("AsIs")
setMethod("toJSON", "AsIs",
           function(x, container =  isContainer(x, asIs, .level), collapse = "\n", ..., .level=1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE, asIs = NA) {
              toJSON(structure(x, class = class(x)[-1]), container = TRUE, collapse = collapse, ..., .level = .level + 1L, .withNames = .withNames, .na = .na, .escapeEscapes = .escapeEscapes, asIs = asIs)
           })



setMethod("toJSON", "matrix",
           function(x, container =  isContainer(x, asIs, .level), collapse = "\n", ...,
                    .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE, pretty = FALSE, asIs = NA) {
             tmp = paste(apply(x, 1, toJSON, .na = .na, ..., .escapeEscapes = .escapeEscapes), collapse = sprintf(",%s", collapse))
             if(!container)
               return(tmp)

              if(.withNames)
                paste("{", paste(dQuote(names(x)), tmp, sep = ": "), "}")                
              else
                paste("[", tmp, "]")
           })

setMethod("toJSON", "list",
           function(x, container = isContainer(x, asIs, .level), collapse = "\n", ..., .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null", .escapeEscapes = TRUE, pretty = FALSE, asIs = NA) {
                # Degenerate case.
#browser()
             if(length(x) == 0) {
                          # x = structure(list(), names = character()) gives {}
                return(if(is.null(names(x))) "[]" else "{}")
             }

             els = lapply(x, toJSON, ..., .level = .level + 1L, .na = .na, .escapeEscapes = .escapeEscapes, asIs = asIs)

             if(all(sapply(els, is.name)))
               names(els) = NULL
             if(missing(container) && is.na(asIs))
                container = TRUE
               
             if(!container)
               return(els)

             els = unlist(els)
             
             if(.withNames)
                paste(sprintf("{%s", collapse),
                      paste(dQuote(names(x)), els, sep = ": ", collapse = sprintf(",%s", collapse)),
                      sprintf("%s}", collapse))
             else
                 paste(sprintf("[%s", collapse), paste(els, collapse = sprintf(",%s", collapse)), sprintf("%s]", collapse))
           })


jsonPretty =
function(txt)
{
   txt = paste(as.character(txt), collapse = "\n")
   enc = mapEncoding(Encoding(txt))
   .Call("R_jsonPrettyPrint", txt, enc, package = "RJSONIO")
}




setMethod("toJSON", "environment",
           function(x, container = isContainer(x, asIs, .level), collapse = "\n  ", ...,
                     .level = 1L, .withNames = length(x) > 0 && length(names(x)) > 0, .na = "null",
                      .escapeEscapes = TRUE, pretty = FALSE, asIs = NA) {
      toJSON(as.list(x), container, collapse, .level = .level, .withNames = .withNames, .escapeEscapes = .escapeEscapes, asIs = asIs)
           })

