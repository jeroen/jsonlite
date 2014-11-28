jsonlite
========

[![Build Status](https://travis-ci.org/jeroenooms/jsonlite.svg?branch=master)](https://travis-ci.org/jeroenooms/jsonlite)

The announcement [blog post](https://public.opencpu.org/posts/jsonlite-a-smarter-json-encoder/) has a one minute introduction to the package.

> Premature optimization is the root of all evil. - Donald Knuth

This package implements `toJSON` and `fromJSON` functions similar to those in packages as `RJSONIO` and `rjson`, but options and output are quite different. The initial emphasis in `jsonlite` has been on correctness: rather than rushing towards performance, we want to explicity specify intended behavior covering all important structures. The complexity of this problem is easily understimated, which can result in unexpected behavior, ambiguous edge cases and differences between implementations. Some conventions for a consistent and practical mapping are proposed in the [package vignette](http://cran.r-project.org/web/packages/jsonlite/vignettes/json-mapping.pdf). Feel free to join the discussion. 

For the parts where there is consensus on the spec, we can shift gears towards optimization. You can submit patches or pull requests with performance tweaks, as long as they don't alter the behavior of the functions. Make sure to run at leasts the unit tests:

    library(testthat)
    test_packages("jsonlite")

Alternatively, you could reimplement the entire thing in something like C++ and use `jsonlite` as a reference implementation.
