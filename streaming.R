library(RJSONIO); f= "inst/sampleData/web.json"; .Call("R_json_parser_test_stream", f)

library(RJSONIO); f= "inst/sampleData/web.json"; .Call("R_json_parser_test_stream_str", '[1,2, 3]{"a": [true, false]}')

library(RJSONIO); f= "inst/sampleData/web.json"; .Call("R_json_parser_test_stream_str", paste(readLines("inst/sampleData/web.json"), collapse = "\n"))


library(RJSONIO)
val = list(a = 1:100, b = 100:1, c = rnorm(1000))
xx = toJSON(val, digits = 16)
ans = .Call("R_json_parser_test_stream_str", xx)

# in chunks
ans = .Call("R_json_parser_test_stream_chunk", xx)
all.equal(val, ans)




library(RJSONIO)
val = list(a = 1:100, b = 100:1, c = rnorm(1000))
xx = toJSON(val, digits = 16)

con = textConnection(xx)
getData = function()  readLines(con, n = 1)

ans = .Call("R_json_parser_test_stream_chunk_con", quote(getData()))




library(RJSONIO)
val = list(a = 1:100, b = 100:1, c = rnorm(1000))
xx = toJSON(val, digits = 16)

con = textConnection(xx)
e = substitute(readLines(con, n = 1), list(con = con))

ans = .Call("R_json_parser_test_stream_chunk_con", e)
all.equal(ans, val)


####################

library(RJSONIO)
val = list(a = 1:100, b = 100:1, c = rnorm(1000))
xx = toJSON(val, digits = 16)

con = textConnection(xx)
e = substitute(readLines(con, n = 1), list(con = con))

ans = .Call("R_json_parser_init_from_con",  e, NULL)
all.equal(ans, val)

  #  With a callback
library(RJSONIO)
val = list(a = 1:100, b = 100:1, c = rnorm(1000))
xx = toJSON(val, digits = 16)

con = textConnection(xx)
e = substitute(readLines(con, n = 1), list(con = con))

f = function(x)
       print(x)
 
ans = .Call("R_json_parser_init_from_con",  e, f)
all.equal(ans, val)


library(RJSONIO)
xx = '[1,2, 3]{"a": [true, false]}'
con = textConnection(xx)
e = substitute(readLines(con, n = 1), list(con = con))

f = function(x)
       print(sum(unlist(x)))
 
ans = .Call("R_json_parser_init_from_con",  e, f)

