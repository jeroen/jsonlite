library(jsonlite)
library(microbenchmark)

# dataset: 53940 x 10 = 0.54M values
data(diamonds, package="ggplot2")

# toJSON(dataframe)
microbenchmark(toJSON(diamonds), times=10) #1.20
microbenchmark(toJSON(diamonds, dataframe = "columns"), times=10) #0.40

# fromJSON(dataframe)
diamonds_json <- toJSON(diamonds)
microbenchmark(fromJSON(diamonds_json), times=10) #2.20

# dataset: 227496 x 21 = 4.7M values
data(hflights, package="hflights")
microbenchmark(toJSON(hflights), times=10) #8.70
microbenchmark(toJSON(hflights, dataframe = "columns"), times=10) #3.40

hflights_json <- toJSON(hflights)
microbenchmark(fromJSON(hflights_json), times=10) #20.50
