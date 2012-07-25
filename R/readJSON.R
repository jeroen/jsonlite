setOldClass("connection")
setOldClass(c("textConnection", "connection"))
setOldClass(c("file", "connection"))
setOldClass(c("pipe", "connection"))
setOldClass("AsIs")
setOldClass("Filename")
setOldClass("FileContent")
setOldClass("JSONParserHandler")
setOldClass("NativeSymbolInfo")
setOldClass("NativeSymbol")

isContent = 
function(content)
{
  inherits(content, "AsIs") || (!file.exists(content) && length(grep("^[[:space:]]*[[{]", content)))
}

StrictLogical = 2L
StrictNumeric = 4L
StrictCharacter = 8L

Strict = StrictNumeric + StrictCharacter + StrictLogical

setGeneric("fromJSON",
            function(content, handler = NULL, default.size = 100, depth = 150L,
                      allowComments = TRUE,  asText = isContent(content),
                       data = NULL, maxChar = c(0L, nchar(content)), simplify = Strict,  nullValue = NULL,
                        simplifyWithNames = TRUE, encoding = NA_character_, stringFun = NULL, ...)
                  standardGeneric("fromJSON"))

setMethod("fromJSON", c("AsIs", handler = "NULL"),
function(content,  handler = NULL, default.size = 100, depth = 150L,
	 allowComments = TRUE,  asText = isContent(content),
            data = NULL, maxChar = c(0L, nchar(content)), simplify = Strict, nullValue = NULL, simplifyWithNames = TRUE,  encoding = NA_character_, stringFun = NULL, ...)
{
   stringFunType = c("GARBAGE" = 4L)
   enc = mapEncoding(if(is.na(encoding)) Encoding(content) else encoding)
   if(!is.null(stringFun)) {
       if(!is.function(stringFun)) {
           stringFunType = getStringRoutineType(stringFun)
           if(is.character(stringFun))
             stringFun = getNativeSymbolInfo(stringFun)
           if(is(stringFun, "NativeSymbolInfo"))
             stringFun = stringFun$address
           else if( typeof(stringFun) != "externalptr")
             stop("stringFun needs to be a function or identify a native routine")
       } else 
          stringFunType = c("R_FUNCTION" = 2L)
   }

  .Call("R_fromJSON", content, as.integer(sum(simplify)), nullValue, as.logical(simplifyWithNames), enc,
             stringFun, stringFunType)  
})

mapEncoding =
function(encoding)
{
  if(is.na(encoding))
      return(0L)

  codes = c(unknown = 0L, "native" = 0L, "utf8" = 1L,  "utf-8" = 1L, "latin1" = 2L, "bytes" = 3L, "symbol" = 5L, "any" = 99L)
  i = pmatch(tolower(encoding), names(codes))
  if(is.na(i)) {
      stop("unrecognized encoding")
  }

  codes[i]
}

setMethod("fromJSON", "AsIs",
function(content, handler = NULL, default.size = 100,
         depth = 150L, allowComments = TRUE, asText = isContent(content),
            data = NULL, maxChar = c(0L, nchar(content)), simplify = Strict, nullValue = NULL, simplifyWithNames = TRUE,  encoding = NA_character_,  stringFun = NULL, ...)  
{
   fromJSON(as.character(content), handler, default.size, depth, allowComments, asText = TRUE, data, maxChar,
             simplify = simplify, ..., nullValue = nullValue, simplifyWithNames = simplifyWithNames, encoding = encoding, stringFun = stringFun)  
})



setMethod("fromJSON", c("character"),
function(content, handler = NULL,
          default.size = 100, depth = 150L, allowComments = TRUE, asText = isContent(content),
            data = NULL, maxChar = c(0L, nchar(content)), simplify = Strict, nullValue = NULL, simplifyWithNames = TRUE,
             encoding = NA_character_, stringFun = NULL, ...)  
{
  if(!asText) {
    content = I(suppressWarnings(paste(readLines(content), collapse = "\n")))
    maxChar = c(0L, nchar(content))
  } else
    content = I(content)

  fromJSON(content, handler, default.size, depth, allowComments, asText = FALSE, data, maxChar, simplify = simplify, ...,
             nullValue = nullValue, simplifyWithNames = simplifyWithNames, encoding = encoding, stringFun = stringFun)
})

  
setMethod("fromJSON", c("AsIs", "JSONParserHandler"),
function(content, handler = NULL,
          default.size = 100, depth = 150L, allowComments = TRUE, asText = isContent(content),
            data = NULL, maxChar = c(0L, nchar(content)), simplify = Strict, nullValue = NULL, simplifyWithNames = TRUE, encoding = NA_character_, stringFun = NULL, ...)  
{
  fromJSON(content, handler$update, depth = depth, allowComments = allowComments, maxChar = maxChar, simplify = simplify, ..., nullValue = nullValue, simplifyWithNames = simplifyWithNames, encoding = encoding, stringFun = stringFun)
  handler$value()
})

setMethod("fromJSON", c("AsIs", "function"),
function(content, handler = NULL,
          default.size = 100, depth = 150L, allowComments = TRUE, asText = isContent(content),
            data = NULL, maxChar = c(0L, nchar(content)), simplify = Strict, nullValue = NULL, simplifyWithNames = TRUE,
             encoding = NA_character_, stringFun = NULL, ...)  
{
  oldFromJSON(content, handler, depth = depth, allowComments = allowComments, maxChar = maxChar, simplify = simplify, ..., simplifyWithNames = simplifyWithNames, nullValue = nullValue, encoding = encoding, stringFun = stringFun)
})

setMethod("fromJSON", c("AsIs", "NativeSymbolInfo"),
function(content, handler = NULL,
          default.size = 100, depth = 150L, allowComments = TRUE, asText = isContent(content),
            data = NULL, maxChar = c(0L, nchar(content)), simplify = Strict, nullValue = NULL, simplifyWithNames = TRUE,
            encoding = NA_character_, stringFun = NULL, ...)  
{
  oldFromJSON(content, handler$address, depth = depth, allowComments = allowComments, data = data, maxChar = maxChar,
               simplify = simplify, ..., simplifyWithNames = simplifyWithNames, nullValue = nullValue, encoding = encoding, stringFun = stringFun)
})

oldFromJSON = 
function(content, handler = NULL,
          default.size = 100, depth = 150L, allowComments = TRUE, asText = isContent(content),
            data = NULL, maxChar = c(0L, nchar(content)), simplify = Strict, nullValue = NULL, simplifyWithNames = TRUE,
             encoding = NA_character_, ...)  
{
  if(inherits(handler, "NativeSymbol")) {
     data = list(handler, data)
     fun = NULL
  } else
     fun = handler

   # Would like to allow the caller specify maxChar and not override it here.
   # But the conversion to raw might yield a vector longer than the number of 
   # characters in x.
  content = substring(content, maxChar[1], maxChar[2])
  cntnt = as.integer(charToRaw(content))
  maxChar = c(0L, length(cntnt))
    
  ans = .Call("R_readFromJSON", cntnt, as.integer(depth), as.logical(allowComments),
                                 fun, data, maxChar)

  if(inherits(handler, "NativeSymbol"))
    data[[2]]
  else
    ans
}

setMethod("fromJSON", "connection",
function(content, handler = NULL, default.size = 100,
         depth = 150L, allowComments = TRUE, asText = isContent(content),
            data = NULL, maxChar = c(0L, nchar(content)), 
             simplify = Strict, nullValue = NULL, simplifyWithNames = TRUE, encoding = NA_character_,
             stringFun = NULL, maxNumLines = -1L, ...)  
{
  txt = paste(readLines(content, maxNumLines), collapse = "\n")
#browser()  
  fromJSON(I(txt), handler, default.size, depth, allowComments, asText = TRUE, data = data, maxNumLines = maxNumLines,
             simplify = simplify, ..., nullValue = nullValue, simplifyWithNames = simplifyWithNames,
               encoding = encoding, stringFun = stringFun)
})


if(FALSE) 
setMethod("fromJSON", "connection",
    # This will be changed so that the code that passes content to the JSON parser
    # calls   readLines(, n = numLines) on the connection
function(content, handler = NULL, default.size = 100,
         depth = 150L, allowComments = TRUE, asText = isContent(content),
            data = NULL, maxNumLines = -1L, ...)  
{
  handlerFun = inherits(handler, "JSONParserHandler")
  if(handlerFun) {
    fun = handler$update
  } else
    fun = handler

  if(inherits(handler, "NativeSymbolInfo"))
    handler = handler$address

  if(inherits(handler, "NativeSymbol")) {
     data = list(handler, data)
     fun = NULL
   }
  
  if(!isOpen(content)) {
     open(content, "r")
     on.exit(close(content))
  }

  ans = .Call("R_readFromJSON", content, as.integer(depth), as.logical(allowComments),
                                 fun, data, as.integer(maxNumLines))

  if(inherits(handler, "NativeSymbol"))
    data[[2]]
  else if(handlerFun) {
    handler$value()
  } else
    ans

  
#  fromJSON(content, handler, depth, allowComments, asText = TRUE, data, ...) 
#   fromJSON(paste(readLines(content), collapse = "\n"), handler, depth, allowComments, asText = TRUE, data, ...)
})


# Constants that identify the different elements/tokens.
JSON_T_NONE = 0
JSON_T_ARRAY_BEGIN = 1
JSON_T_ARRAY_END = 2
JSON_T_OBJECT_BEGIN = 3
JSON_T_OBJECT_END = 4
JSON_T_INTEGER = 5
JSON_T_FLOAT = 6
JSON_T_NULL = 7
JSON_T_TRUE = 8
JSON_T_FALSE = 9
JSON_T_STRING = 10
JSON_T_KEY = 11
JSON_T_MAX = 12

basicJSONHandler =
  #
  # A handler to read generic JSON content
  #
function(default.size = 100, simplify = FALSE)  # currently ignored.
{

   stack = NULL
   cur = NULL
   numKeys = 0
   curKey = character() # default.size)
   curLength = c(0L)

   update = function(type, val) {

      if(type == JSON_T_KEY) {
            # a key for a hash table.
         numKeys <<- numKeys + 1
         if(length(curKey) < numKeys)
           length(curKey) <<- numKeys
         #curKey[numKeys] <<- val
         curKey <<- c(val, curKey)
      } else if(type == JSON_T_ARRAY_BEGIN || type == JSON_T_OBJECT_BEGIN) {
         stack <<- list(cur, stack)
         cur <<- vector("list", default.size)
         
         curLength <<- c(0, curLength)
      } else if(type == JSON_T_ARRAY_END || type == JSON_T_OBJECT_END) {
         tmp = trimCur()

         obj = if(type == JSON_T_ARRAY_END && simplify)
                 condense(tmp)
               else
                 tmp
         if(type == JSON_T_OBJECT_END) {
            i = seq(along = obj)
            names(obj) = rev(curKey[i]) # rev(curKey[i])
            curKey <<- curKey[-i]            
         }

         cur <<- stack[[1]]
         if(length(stack) > 1)
             stack <<- stack[[2]]

         extendCur()
         cur[[ curLength[1] ]] <<- obj
      } else if(type > JSON_T_OBJECT_END  && type < JSON_T_KEY) {
            # The actual atomic values
        
         extendCur()        
         cur[[ curLength[1] ]] <<- val
      }

      TRUE
   }

   trimCur =
     function()
     {
       n = curLength[1]
       curLength <<- curLength[-1]
       cur[1:n]
     }
   
   extendCur =
     function() {
       curLength[1] <<- curLength[1] + 1               
       if(length(cur) < curLength[1])
         length(cur) <<- 2 * length(cur)
     }

       

   getValue =
     function(simplify = TRUE) {
       if(simplify && length(cur) == 1)
          cur[[1]]
       else {
          cur
       }
     }

   structure(list(update = update,
                  value = getValue),
             class = "JSONParserHandler")
}

condense =
  #
  # Characters so no mixing
  # condense(list(c(1, 2, 3), c("a", "b", "c")))
  #
  # Mixing of logical, numerical, integer
  # condense(list(c(1L, 2L, 3L), c(4, 5, 6), c(TRUE, TRUE, FALSE)), strict = TRUE)
  # condense(list(c(1L, 2L, 3L), c(4, 5, 6), c(TRUE, TRUE, FALSE)), strict = FALSE)

  #  Different lengths
  #   condense(list(c(1, 2, 3), c(4, 5), c(TRUE, TRUE, FALSE)), strict = TRUE)
  #
function(val, strict = FALSE)
{
  if(length(names(val)) || any(sapply(val, function(x) length(names(x))) > 0))
      return(val)
  
  lens = sapply(val, length)
  if(all( lens == 1)) {
    atomic = sapply(val, is.atomic)
    if(!all(atomic))
      return(val)

    return(unlist(val))
  } else {
    els = unlist(val)
    if(length(els) == 0)
      return(NULL)
    
    types = sapply(val, typeof)
    if(all(lens == lens[1]) &&
       (strict && all(types == types[1]) ||
        (!strict &&  (!any(types == "character")  || all(types == "character")  ))))
      return(matrix(els, , lens[1], byrow = TRUE))
  }

  val
}

getStringRoutineType = 
function(stringFun)
{
  if(is.function(stringFun))
     return(c("R_FUNCTION" =  3L))

  if(is(stringFun, "AsIs") || is(stringFun, "NativeStringRoutine"))
      c("NATIVE_STR_ROUTINE" = 0L)
  else 
      c("SEXP_STR_ROUTINE" = 1L) 
}
