#script to clean up code
library(formatR)

#see ?tidy.source
options(reindent.spaces=2)
options(replace.assign=TRUE)
lapply(list.files("R", full.name=TRUE), function(x){
  try(tidy.source(x, file=x))
})
