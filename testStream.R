library(RJSONIO)

cb =
function(node)
{
  cat("in cb", .Call("R_json_node_type", node), "\n")
  
  TRUE
}

txt = paste(readLines("inst/sampleData/nestedObj.json"), collapse = "\n")
txt = "[1, 2, 3]"
.Call("R_json_stream_parse", txt, cb)
