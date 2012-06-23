library(RJSONIO)
if(FALSE) {
  jtxt = "[1,\n 2,\n 3,\n 4]"
  con = textConnection(jtxt)
} else {
#  con = file("inst/sampleData/array2.json", "r")
  f = "inst/sampleData/web.json"
#  f = "inst/sampleData/widget.json"  
  
  con = file(f, "r")  
}

streamJSON = 
function(con, cb =function(obj) { cat("Called cb\n"); print(obj)})
{
  getData = function() {
      x = readLines(con, n = 1)
      cat("R: ", sQuote(x), "\n", sep = "")
      if(length(x))
         sprintf("%s\n", x)
      else
         character()
  }
#  conCall = substitute({x = readLines(con, n = 1); cat(x, "\n"); if(length(x)) sprintf("%s\n", x) else character()}, list(con = con))
  cbCall = substitute(foo(val), list(foo = cb))

  .Call("R_json_parser_init_from_con", getData, cbCall)
}

streamJSON(con)
