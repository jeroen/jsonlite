library(RJSONIO)
a = array(1:(5*7*9), c(5, 7, 9))
o = toJSON(a)
isValidJSON(I(o))
b = fromJSON(I(o))

toJSON(table(1:3))
toJSON(table(1:3, 1:3))

#z = apply(a, 3, function(x, dim) toJSON(x))
#toJSON(array(1:8,c(2,2,2)))
