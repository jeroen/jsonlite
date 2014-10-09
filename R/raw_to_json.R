# This function deals with some uncertainty in character encoding when reading
# from files and URLs. It tries UTF8 first, but falls back on native if it is
# certainly not UTF8.
raw_to_json <- function(x){
  txt <- rawToChar(x);
  Encoding(txt) <- "UTF-8"
  isvalid <- validate(txt)
  if(!isvalid && grepl("invalid bytes in UTF8", attr(isvalid, "err"), fixed=TRUE, useBytes=TRUE)){
    message("File does not seem to be UTF-8. Using native encoding instead.")
    Encoding(txt) <- "";
  }
  return(txt)
}
