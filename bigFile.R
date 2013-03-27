library(RJSONIO)

checkValidity <- function(N, parse = FALSE, short = FALSE) {
    l = if(short)
           lapply(1:N, function(x) sample(10L, 10, replace = TRUE))
        else
           lapply(1:10, function(x) sample(10L, N, replace = TRUE))
#    names(l) <- letters[1:10]

    a <- toJSON(l)

    message("JSON document of size: ", nchar(a))
    if(parse)
       fromJSON(a, asText = TRUE)
    else
       isValidJSON(a, asText = TRUE)
}



if(FALSE) {
  checkValidity(1e3L)

#JSON document of size:31049

#[1] TRUE

 checkValidity(1e6L)

#JSON document of size:31002696

#[1] TRUE

 checkValidity(2e6L)

#JSON document of size:61999858
#[1] FALSE
}
