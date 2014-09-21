cleannames <- function(objnames){
  objnames[objnames == ""] <- NA_character_
  is_missing <- is.na(objnames)
  objnames[is_missing] <- as.character(seq_len(length(objnames)))[is_missing]
  make.unique(objnames)
}
