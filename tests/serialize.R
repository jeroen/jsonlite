library(RJSONIO)
setClass("A", representation(x = "integer", abc = "character"),
          prototype = list(x = 1:10, abc = c("Jan", "Feb", "Mar")))
a = new("A")

toJSON(a)

toJSON(list(a, a))

