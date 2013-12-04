jsonlite
========

> Premature optimization is the root of all evil. - Donald Knuth

This package implements `toJSON` and `fromJSON` functions similar to those in packages as `RJSONIO` and `rjson`, but with a different mapping between R objects and JSON strings. The initial emphasis in `jsonlite` is on correctness: rather than rushing to performance tweaks, we want to explicity specify intended behavior covering all important structures. The complexity of this problem is easily understimated, which can result in unexpected behavior, ambiguous edge cases and differences between implementations. Some conventions for a consistent and practical mapping are proposed in the [package vignette](https://raw.github.com/jeroenooms/jsonlite/master/vignettes/json-mapping.pdf). Feel free to join the discussion. Once we are converging to consensus on the spec, we can shift gears towards optimizing performance (or reimplement the entire thing in C++).
