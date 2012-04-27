simpleJSONHandler = 
  #
  # A handler to read generic JSON content
  #
function()
{
   stack = NULL
   cur = NULL
   curKey = character()

   update = function(type, val) {

      if(type == JSON_T_KEY) {
            # a key for a hash table.
         curKey <<- c(val, curKey)
      } else if(type == JSON_T_ARRAY_BEGIN || type == JSON_T_OBJECT_BEGIN) {
         stack <<- list(cur, stack)
         cur <<- list()
      } else if(type == JSON_T_ARRAY_END || type == JSON_T_OBJECT_END) {
         obj = if(type == JSON_T_ARRAY_END) condense(cur) else cur
         if(type == JSON_T_OBJECT_END) {
            i = seq(along = obj)
            names(obj) = rev(curKey[i])
            curKey <<- curKey[-i]            
         }

         cur <<- stack[[1]]
         if(length(stack) > 1)
             stack <<- stack[[2]]

         cur[[ length(cur) + 1 ]] <<- obj
      } else if(type > JSON_T_OBJECT_END  && type < JSON_T_KEY) {
            # The actual atomic values
         cur[[length(cur) + 1]] <<- val
      }

      TRUE
   }

   getValue =
     function(simplify = TRUE) {
       if(simplify && length(cur) == 1)
          cur[[1]]
       else
          cur
     }

   structure(list(update = update,
                  value = getValue),
             class = "JSONParserHandler")
}




