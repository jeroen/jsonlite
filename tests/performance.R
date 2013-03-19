if(FALSE) {  # This works but takes a lot of time. So leave this out
             # for default runs.
library(RJSONIO)

v = rpois(100000, 4)
x = toJSON(v)

 # 0.054  seconds
system.time({ val = fromJSON(x, getNativeSymbolInfo("R_json_IntegerArrayCallback"),
                              data = rep(as.integer(NA), 100000))})

all(v == val)

# 89.981 So a factor of 1666
system.time({v1 = fromJSON(x)})


# Now if we preallocate a vector with the size of the result
# and fill it with an R callback, we get 1.050.
# This is a factor of 20 relative to the specialized C code.
gen =
function(n = 100000, ans = integer(n))
{
  pos = 1
  update =
  function(type, val) {
    if(type == JSON_T_INTEGER) {
      ans[pos] <<- val
      pos <<- pos + 1
    }
    TRUE
  }
  list(update = update, value = function() ans)
}
h = gen()
system.time({v1 = fromJSON(x, h$update)})


# Now let's use the generic list
# We get 1.130

gen.list =
function(n = 100000, ans = vector("list", n))
{
  pos = 1
  update =
  function(type, val) {
    if(type == JSON_T_INTEGER) {
      ans[pos] <<- val
      pos <<- pos + 1
    }
    TRUE
  }
  structure(list(update = update, value = function() unlist(ans[1:pos])),
             class = "JSONParserHandler")
}
h = gen.list()
system.time({v1 = fromJSON(x, h)})


#
gen.list =
function(n = 100000, ans = vector("list", n))
{
  pos = 1
  update =
  function(type, val) {
    if(type == JSON_T_INTEGER) {
      if(length(ans) == pos)
        length(ans) <<- 2*pos
      ans[pos] <<- val
      pos <<- pos + 1
    }
    TRUE
  }
  structure(list(update = update, value = function() unlist(ans[1:pos])),
             class = "JSONParserHandler")
}
h = gen.list()
system.time({v1 = fromJSON(x, h)})



############################################

v = rpois(100000, 4)
x = toJSON(v)

h = RJSONIO:::simpleJSONHandler()
system.time({a = fromJSON(x, h)})
#   user  system elapsed 
# 59.470  21.693  91.442 
system.time({a = fromJSON(x)})
#   user  system elapsed 
#  3.899   0.117   4.415 
system.time({a = fromJSON(x, default.size = 10000)})
#   user  system elapsed 
#  3.957   0.116   4.465 
system.time({a = fromJSON(x, default.size = 100000)})
}
