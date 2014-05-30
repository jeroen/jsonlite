#This is a workaround for SSL handshake problems in curl
download <- function(URL){
  req <- tryCatch(
    httr::GET(URL, httr::config(
      httpheader=c(`User-Agent` = "RCurl-httr-jsonlite")
    )), SSL_CONNECT_ERROR = function(e){
      #retry with different SSL settings
      res <- httr::GET(URL, httr::config(
        httpheader=c(`User-Agent` = "RCurl-httr-jsonlite"), 
        sslversion = 3, 
        ssl.verifypeer = FALSE, 
        ssl.verifyhost = FALSE
      ));
      #if this worked, show a warning. If not, it will error anyway.
      warning(e$message, call. = FALSE)
      return(res)
    }
  );
  httr::stop_for_status(req)
  rawToChar(req$content)
}
