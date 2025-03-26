library(testthat)
library(jsonlite)

test_check("jsonlite", filter = "toJSON|fromJSON|libjson|serializeJSON")
