library(RJSONIO)

str = "[ 1, {}, [1, 3, 5] ]"
v = fromJSON(str)
str1 = toJSON(v, collapse = " ")

stopifnot( any( duplicated( gsub("[[:space:]]", "", c(str, str1)))))


