#install_github("jeroenooms/lineprof)
library(lineprof)
library(jsonlite)

data(hflights, package="hflights")
l1 <- lineprof(json <- toJSON(hflights))
l2 <- lineprof(fromJSON(json))

summary(l1, 8)
summary(l2, 8)
