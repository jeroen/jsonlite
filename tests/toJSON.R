library(RJSONIO)

toJSON(list(1, 2, list(1, NA)))

toJSON(list(1, 2, list(NA)))  # collapses the sub-list into the main vector.
