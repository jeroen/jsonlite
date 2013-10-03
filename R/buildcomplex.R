# TODO: Add comment
# 
# Author: jeroen
###############################################################################


buildcomplex <- function(x){
	if(is.list(x) && !is.null(x$real) && !is.null(x$imaginary)){
		#assume list(real=[], complex=[]) notation
		return(complex(re=null2na(x$real), im=null2na(x$imaginary)));
	} else {
		#assume string notation
		return(as.complex(null2na(x)));		
	}
}
