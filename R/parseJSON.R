parseJSON <- function(txt){
  #this is always a bad idea
  simplifyWithNames = FALSE;
  
  #readLines splits into a vector
  txt <- paste(txt, collapse="\n")
  
  #in case if chineese, etc.
  encoding <- mapEncoding(Encoding(txt));
  
  #libjson call
  .Call("R_fromJSON", PACKAGE="jsonlite", txt, as.integer(FALSE), NULL, simplifyWithNames, encoding, NULL, stringFunType = c("GARBAGE" = 4L))    
}
