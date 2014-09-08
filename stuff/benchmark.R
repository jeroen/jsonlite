library(jsonlite)
library(microbenchmark)

# medium dataset: 53940 x 10 = 0.54M values
data(diamonds, package="ggplot2")
dmd_rows <- toJSON(diamonds)
dmd_cols <- toJSON(diamonds, dataframe = "columns")
microbenchmark(
  toJSON(diamonds), #0.60
  toJSON(diamonds, dataframe = "columns"), #0.32
  fromJSON(dmd_rows), #1.15
  fromJSON(dmd_cols), # 0.41
  times=10
)

# larger dataset: 227496 x 21 = 4.7M values
data(hflights, package="hflights")
hfl_rows <- toJSON(hflights)
hfl_cols <- toJSON(hflights, dataframe="columns")
microbenchmark(
  toJSON(hflights), #4.92
  toJSON(hflights, dataframe = "columns"), #2.80
  fromJSON(hfl_rows), #12.30
  fromJSON(hfl_cols), #4.02
  times=5
)
