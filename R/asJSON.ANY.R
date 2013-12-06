setMethod("asJSON", "ANY", function(x, force = FALSE, ...) {
  if (isS4(x) && !is(x, "classRepresentation")) {
    if (isTRUE(force)) {
      return(asJSON(attributes(x), ...))
    } else {
      stop("No S4 method for object of class:", class(x))
    }
  } else if (length(class(x)) > 1) {
    # If an object has multiple classes, we recursively try the next class. This is S3 style dispatching that doesn't work
    # by default for formal method definitions There should be a more native way to accomplish this
    return(asJSON(structure(x, class = class(x)[-1]), ...))
  } else if (isTRUE(force) && existsMethod("asJSON", class(unclass(x)))) {
    # As a last resort we can force encoding using the unclassed object
    return(asJSON(unclass(x), ...))
  } else {
    # If even that doesn't work, we give up.
    stop("No S3 method asJSON for class: ", class(x))
  }
}) 
