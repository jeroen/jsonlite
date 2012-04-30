library(RJSONIO)
jtxt = '[ 1, "abc", "xyz"]'
jdate = '[ 1, "/Date(1335746208)/", "xyz"]'

fromJSON(jtxt, stringFun = getNativeSymbolInfo("dummyStringOperation")$address)

fromJSON(jtxt, stringFun = getNativeSymbolInfo("dummyStringOperation"))
fromJSON(jtxt, stringFun = "dummyStringOperation")

ans = fromJSON(jtxt, stringFun = structure("R_json_dateStringOp", class = "SEXPRoutine"))
sapply(ans, class) == c("numeric", "character", "character")

ans = fromJSON(jdate, stringFun = structure("R_json_dateStringOp", class = "SEXPRoutine"))

ans = fromJSON(jdate, stringFun = I("R_json_dateStringOp"))



fromJSON(jtxt, stringFun = function(val) val)

fromJSON(jtxt, stringFun = function(val) sprintf("xxx_%s", val))

