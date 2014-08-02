#This is a workaround for SSL handshake problems in curl
download <- function(URL){

  #retry with different SSL settings
  download_retry_ssl <- function(e){
    res <- httr::GET(URL, httr::config(
      httpheader=c(`User-Agent` = "RCurl-httr-jsonlite", Accept="application/json, text/*, */*"),
      sslversion = 3,
      ssl.verifypeer = FALSE,
      ssl.verifyhost = FALSE
    ));
    #if this worked, show a warning. If not, it will just error.
    warning(e$message, call. = FALSE)
    return(res)
  }

  req <- tryCatch(
    httr::GET(URL, httr::config(
      httpheader=c(`User-Agent` = "RCurl-httr-jsonlite", Accept="application/json, text/*, */*")
    )),
    SSL_CONNECT_ERROR = download_retry_ssl,
    SSL_PEER_CERTIFICATE = download_retry_ssl,
    SSL_CERTPROBLEM = download_retry_ssl,
    SSL_CACERT = download_retry_ssl
  );
  httr::stop_for_status(req);
  ctype <- req$headers[["content-type"]]
  if(!grepl("json", ctype)){
    warning("Unexpected Content-Type: ", ctype, call. = FALSE)
  }
  rawToChar(req$content);
}
