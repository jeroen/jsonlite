library(RJSONIO)
jtxt = '[ 1, "abc", "xyz"]'
jdate = '[ 1, "/Date(1335746208)/", "xyz"]'
jnewdate = '[ 1, "/new Date(1335746208)/", "xyz"]'



a = fromJSON(jtxt, stringFun = I(getNativeSymbolInfo("dummyStringOperation")$address))
b = fromJSON(jtxt, stringFun = I(getNativeSymbolInfo("dummyStringOperation")))
c = fromJSON(jtxt, stringFun = I("dummyStringOperation"))
d = fromJSON(jtxt, stringFun = structure("dummyStringOperation", class = "NativeStringRoutine"))

e = fromJSON(jtxt, stringFun = I("dummyStringOperation"), simplify = TRUE)


ans = fromJSON(jtxt, stringFun = structure("R_json_dateStringOp", class = "SEXPRoutine"))
sapply(ans, class) == c("numeric", "character", "character")
ans = fromJSON(jtxt, stringFun = "R_json_dateStringOp")

ans = fromJSON(jtxt, stringFun = structure("R_json_dateStringOp", class = "SEXPRoutine"), simplify = TRUE)

 # process jdate
ans = fromJSON(jdate, stringFun = structure("R_json_dateStringOp", class = "SEXPRoutine"))
ans = fromJSON(jdate, stringFun = "R_json_dateStringOp")


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

ans = fromJSON(jtxt, stringFun = "R_json_dateStringOp")
stopifnot(all(mapply(is, ans, c("numeric", "POSIXct", "POSIXct"))))


