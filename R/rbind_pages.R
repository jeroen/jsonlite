#' Combine pages into a single data frame
#'
#' The \code{rbind_pages} function is used to combine a list of data frames into a single
#' data frame. This is often needed when working with a JSON API that limits the amount
#' of data per request. If we need more data than what fits in a single request, we need to
#' perform multiple requests that each retrieve a fragment of data, not unlike pages in a
#' book. In practice this is often implemented using a \code{page} parameter in the API. The
#' \code{rbind_pages} function can be used to combine these pages back into a single dataset.
#'
#' The \code{\link{rbind_pages}} function generalizes \code{\link[base:cbind]{base::rbind}} and
#' \code{\link[plyr:rbind.fill]{plyr::rbind.fill}} with added support for nested data frames. Not each column
#' has to be present in each of the individual data frames; missing columns will be filled
#' up in \code{NA} values.
#'
#' @export
#' @param pages a list of data frames, each representing a \emph{page} of data
#' @examples # Basic example
#' x <- data.frame(foo = rnorm(3), bar = c(TRUE, FALSE, TRUE))
#' y <- data.frame(foo = rnorm(2), col = c("blue", "red"))
#' rbind_pages(list(x, y))
#'
#' \donttest{
#' baseurl <- "https://projects.propublica.org/nonprofits/api/v2/search.json"
#' pages <- list()
#' for(i in 0:20){
#'   mydata <- fromJSON(paste0(baseurl, "?order=revenue&sort_order=desc&page=", i))
#'   message("Retrieving page ", i)
#'   pages[[i+1]] <- mydata$organizations
#' }
#' organizations <- rbind_pages(pages)
#' nrow(organizations)
#' colnames(organizations)
#' }
rbind_pages <- function(pages){
  #Load plyr
  loadpkg("plyr")

  #validate input
  stopifnot(is.list(pages))

  # edge case
  if(!length(pages)){
    return(data.frame())
  }

  # All elements must be data frames or NULL.
  pages <- Filter(function(x) {!is.null(x)}, pages);
  stopifnot(all(vapply(pages, is.data.frame, logical(1))))

  # Extract data frame column names
  dfdf <- lapply(pages, vapply, is.data.frame, logical(1))
  dfnames <- unique(names(which(unlist(unname(dfdf)))))

  # No sub data frames
  if(!length(dfnames)){
    return(plyr::rbind.fill(pages))
  }

  # Extract the nested data frames
  subpages <- lapply(dfnames, function(colname){
    rbind_pages(lapply(pages, function(df) {
      if(!is.null(df[[colname]]))
        df[[colname]]
      else
        as.data.frame(matrix(nrow=nrow(df), ncol=0))
    }))
  })

  # Remove data frame columns
  pages <- lapply(pages, function(df){
    issubdf <- vapply(df, is.data.frame, logical(1))
    if(any(issubdf))
      df[issubdf] <- rep(NA, nrow(df))
    df
  })

  # Bind rows
  outdf <- plyr::rbind.fill(pages)

  # Combine wih sub dataframes
  for(i in seq_along(subpages)){
    outdf[[dfnames[i]]] <- subpages[[i]]
  }

  #out
  outdf
}
