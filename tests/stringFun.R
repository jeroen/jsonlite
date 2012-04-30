library(RJSONIO)
jtxt = '[ 1, "abc", "xyz"]'
jdate = '[ 1, "/Date(1335746208)/", "xyz"]'
jnewdate = '[ 1, "/new Date(1335746208)/", "xyz"]'

fromJSON(jtxt, stringFun = getNativeSymbolInfo("dummyStringOperation")$address)

fromJSON(jtxt, stringFun = getNativeSymbolInfo("dummyStringOperation"))
fromJSON(jtxt, stringFun = "dummyStringOperation")

fromJSON(jtxt, stringFun = "dummyStringOperation", simplify = TRUE)


ans = fromJSON(jtxt, stringFun = structure("R_json_dateStringOp", class = "SEXPRoutine"))
sapply(ans, class) == c("numeric", "character", "character")

ans = fromJSON(jtxt, stringFun = structure("R_json_dateStringOp", class = "SEXPRoutine"), simplify = TRUE)

ans = fromJSON(jdate, stringFun = structure("R_json_dateStringOp", class = "SEXPRoutine"))

ans = fromJSON(jdate, stringFun = I("R_json_dateStringOp"))


  # process strings by just returning them.
fromJSON(jtxt, stringFun = function(val) val)

  #  process strings by prefixing them with  xxx_
fromJSON(jtxt, stringFun = function(val) sprintf("xxx_%s", val))

jtxt = '[ "1", "2.3", "3.1415"]'  # all numeric but in "" 
ans = fromJSON(jtxt)
stopifnot(is.character(ans))

 # convert all of the strings to numeric!
ans = fromJSON(jtxt, stringFun = function(val) as.numeric(val))
stopifnot(is.numeric(ans))

 # Now convert them all to TRUE as logicals
ans = fromJSON(jtxt, stringFun = function(val) TRUE)
stopifnot(is.logical(ans))


#
jtxt = '[ 1, "/new Date(12312313)", "/Date(12312313)"]'
ans = fromJSON(jtxt)
stopifnot(is.character(ans))

ans = fromJSON(jtxt, stringFun = I("R_json_dateStringOp"))
stopifnot(all(mapply(is, ans, c("numeric", "POSIXct", "POSIXct"))))


