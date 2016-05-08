##BUG in: .Call(C_collapse_array_pretty_inner, x, indent)
## C_collapse_array_pretty_inner has no indent arg?

x <- rnorm(10^5)
y <- structure(x, dim = rep (10, 5))
system.time(toJSON(x))
system.time(toJSON(y))

# Target
x <- structure(1:prod(1:4), dim = 1:4)
jsonlite::toJSON(x, pretty = T)

str <- jsonlite:::asJSON(c(x), collapse = F)
dim(str) <- dim(x)

collapse_recursively <- function(x, indent = 0L, has_collapsed = FALSE, columnmajor = FALSE){
  cat("Indent: ", indent, "\n")
  if(length(dim(x)) < 2){
    jsonlite:::collapse(x, inner = !has_collapsed, indent = indent)
  } else {
    dim <- 1:(length(dim(x))-1) + as.numeric(columnmajor)
    tmp <- apply(x, dim, collapse_recursively, indent = indent + 2L, has_collapsed = has_collapsed, columnmajor = columnmajor)
    collapse_recursively(tmp, indent = indent, has_collapsed = TRUE, columnmajor = columnmajor)
  }
}

# Row major minified
cat(collapse_recursively(str, indent = NA))
jsonlite::toJSON(x, pretty = F)

# Col major minified
cat(collapse_recursively(str, indent = NA, columnmajor = T))
jsonlite::toJSON(x, pretty = F, matrix = "columnmajor")

# Row major pretty
cat(collapse_recursively(str, indent = 0L))
jsonlite::toJSON(x, pretty = T)

# Col major pretty
cat(collapse_recursively(str, indent = 0L, columnmajor = T))
jsonlite::toJSON(x, pretty = T, matrix = "columnmajor")


# Simple example
x <- array(2, c(1,1,1,1,2))
str <- jsonlite:::asJSON(c(x), collapse = F)
dim(str) <- dim(x)
cat(collapse_recursively(str, indent = 0L))
jsonlite::toJSON(x, pretty = T)
