library(RJSONIO)

x0  = list(sub1 = list(a = 1:10, b = 100, c = 1000), sub2 = list(animal1 = "ape", animal2 = "bear", animal3 = "cat"))
y0  = list(sub1 = list(a = 1:10, b = 100L, c = 1000L), sub2 = list(animal1 = "ape", animal2 = "bear", animal3 = "cat"))
z0  = list(sub1 = list(a = 10, b = 100, c = 1000), sub2 = list(animal1 = "ape", animal2 = "bear", animal3 = "cat"))


j0  = toJSON(x0)
x1  = fromJSON(j0, simplify = FALSE)
x2  = fromJSON(j0, simplify = TRUE)
x3  = fromJSON(j0, simplify = Strict)
