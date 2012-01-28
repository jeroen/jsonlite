cb =
function(node)
{
  cat("in cb\n")
  TRUE
}

txt = paste(readLines("inst/sampleData/nestedObj.json"), collapse = "\n")

.Call("R_json_stream_parse", txt, cb)
