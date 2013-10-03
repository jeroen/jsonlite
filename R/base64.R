#These functions have been taken from the base64 package by Francois Romain.
#It was easier to copy then to import.
#They will not be exported


base64_decode <- function(input){
	stopifnot(is.character(input))
	inputtf <- tempfile();
	writeLines(input, inputtf);
	output = tempfile()
	invisible( .Call( "base64_decode_", inputtf, output ) )
	readBin(output, "raw", file.info(output)$size)
}

base64_encode <- function(input, linesize = 72L ){
	stopifnot(is.raw(input));
	inputtf <- tempfile();
	writeBin(input, inputtf)
	output = tempfile();
	invisible( .Call( "base64_encode_", inputtf, output, as.integer(linesize) ) )
	return(readLines(output));
}

base64_img <- function( file, Rd = FALSE, alt = "image" ){
	tf <- tempfile()
	on.exit( unlink(tf) )
	base64_encode( file, tf )
	sprintf( '%s<img src="data:image/png;base64,\n%s" alt="%s" />%s', 
		if( Rd ) "\\out{" else "", 
		paste( readLines( tf) , collapse = "\n" ), 
		alt,
		if( Rd ) "}" else ""
	)	
}
