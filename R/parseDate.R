#dates can be either in string, iso8601, epoch format.

parseDate <- function(x){
	UseMethod("parseDate");
}

#' @method parseDate numeric
#' @S3method parseDate numeric
parseDate.numeric <- function(x){
	isdate <- (abs(x) < 100000);
	if(!all(isdate, na.rm=TRUE)){
		warning("Dates with invalid format:\n\n", x[!isdate]);
	};
	structure(x, class="Date");
}

#' @method parseDate character
#' @S3method parseDate character
parseDate.character <- function(x){
	ISODATE <- "^(\\d{4})\\D?(0[1-9]|1[0-2])\\D?([12]\\d|0[1-9]|3[01])$";
	isdate <- as.logical(regexpr(ISODATE, x));
	#note that grepl doesn't do NA properly
	if(!all(isdate, na.rm=TRUE)){
		warning("Dates with invalid format:\n\n", x[!isdate]);
	};	
	as.Date(strptime(x, "%Y-%m-%d"));
}

#' @method parseDate Date
#' @S3method parseDate Date
parseDate.Date <- identity