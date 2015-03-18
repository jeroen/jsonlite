setMethod("asJSON", "numeric", function(x, digits = 5, use_signif = is(digits, "AsIs"),
  na = c("string", "null", "NA"), auto_unbox = FALSE, collapse = TRUE,
  ..., keep_vec_names = FALSE) {

  na <- match.arg(na);
  na_as_string <- switch(na,
    "string" = TRUE,
    "null" = FALSE,
    "NA" = NA,
    stop("invalid na_as_string")
  )

  # old R implementation
  # tmp <- num_to_char_R(x, digits, na_as_string);

  if (isTRUE(keep_vec_names) && !is.null(names(x))) {
    warn_keep_vec_names()
    return(asJSON(as.list(x), digits = digits, use_signif = use_signif, na = na,
      auto_unbox = TRUE, collapse = collapse, ...))
  }

  # fast C implementation
  tmp <- if(is(x, "integer64")){
    integer64_to_char(x, na_as_string)
  } else {
    num_to_char(x, digits, na_as_string, use_signif);
  }

  if(isTRUE(auto_unbox) && length(tmp) == 1){
    return(tmp);
  }

  if(collapse){
    collapse(tmp)
  } else {
    tmp
  }
})

# This is for the bit64 package
setOldClass("integer64")
setMethod("asJSON", "integer64", getMethod("asJSON", "numeric"));
