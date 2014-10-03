setMethod("asJSON", "numeric", function(x, collapse = TRUE, digits = 5, na = c("string", "null", "NA"), auto_unbox = FALSE, ...) {

  na <- match.arg(na);
  na_as_string <- switch(na,
    "string" = TRUE,
    "null" = FALSE,
    "NA" = NA,
    stop("invalid na_as_string")
  )

  # slower R implementation
  # tmp <- num_to_char_R(x, digits, na_as_string);

  # fast C implementation
  tmp <- num_to_char(x, digits, na_as_string);

  if(isTRUE(auto_unbox) && length(tmp) == 1){
    return(tmp);
  }

  if(collapse){
    collapse(tmp)
  } else {
    tmp
  }
})
