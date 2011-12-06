asJSVars = 
#
# For action script, we often want to declare the variables
# as public/protected and also to put the variables
#
function(..., .vars = list(...), 
          qualifier = character(), types = character())
{
   # Add in suitable indentation
  vals = paste(sapply(.vars, toJSON), ";")
 
  if(length(types)) {
    if(is.logical(types))
      if(types)
         types = sapply(.vars, jsType)
      else  # Should never happen. Caller should leave the default!
         types  = character()

    if(length(types))
      ids = paste(names(.vars), types, sep = " : ")
    else
      ids = names(.vars)
  } else
    ids = names(.vars)

  if(length(qualifier))
    ids = paste(qualifier, ids)

    # Indent the object initialization with the number of characters involved in the
    # variable declaration.
  len = nchar(ids)
  vals = sapply(seq(along = ids),
                  function(i) {
                     gsub("\\\n", paste("\\\n", paste(rep(" ", len[i] + 3), collapse = ""), sep = ""), vals[i])
                  })
  
  invisible(paste(ids, vals, sep = " = ", collapse = "\n\n"))
}

setGeneric("jsType", function(x, ...) standardGeneric("jsType"))

setMethod("jsType", "matrix",
          function(x){
            "Array"
          })

jsTypes = c("integer" = "int",
            "numeric" = "Number",
            "logical" = "Boolean",
            "character" = "String"
           )
    
setMethod("jsType", "vector",
          function(x){
            if(length(x) == 1 && is.atomic(x) && length(names(x)) == 0) {
              jsTypes[typeof(x)]
            } else {
               if(length(names(x)))
                  "Object"
               else
                  "Array"
            }
          })

