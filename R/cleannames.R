cleannames <- function(objnames){
  objnames[is.na(objnames)] <- ""
  objnames[objnames == ""] <- as.character(1:length(objnames))[objnames == ""]
  objnames <- make.unique(objnames)
  objnames
}
