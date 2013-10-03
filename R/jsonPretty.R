jsonPretty <- function(txt) {
	txt = paste(as.character(txt), collapse = "\n")
	enc = mapEncoding(Encoding(txt))
	.Call("R_jsonPrettyPrint", txt, enc)
}