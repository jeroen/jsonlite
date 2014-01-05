.onLoad <- function(lib, pkg){
  #Test if UTF-8 is supported
  sushi <- "寿司";
  if(nchar(sushi) != 2) {
    warning("The preferred character encoding for JSON is UTF-8, however the current system locale is set to: ", Sys.getlocale("LC_CTYPE"), call.=FALSE)
  }
}