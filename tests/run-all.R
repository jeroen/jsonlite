#This file runs all unit tests on every R CMD check.
#Comment this out to disable.

library(testthat)

#filter is to disable tests that rely on external servers
test_package("jsonlite", filter="toJSON|fromJSON|libjson|serializeJSON")
