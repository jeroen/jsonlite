import_json_page <- function(page, validate = FALSE, unicode = FALSE, ...){
  simplify(lapply(page, import_json_single, validate = validate, unicode = unicode), ...)
}

import_json_single <- function(txt, validate, unicode){
  stopifnot(length(txt) == 1L)
  if(validate && !validate(txt)){
    stop("Validation failed. String contains invalid JSON.")
  }

  # preparse escaped unicode characters
  if(unicode){
    txt <- unescape_unicode(txt)
  }

  # return
  parseJSON(txt)
}
