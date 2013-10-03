buildfactor <- function(obj){
	if(is.numeric(obj$value)){
		return(as.integer(null2na(obj$value)));
	} else {
		return(unclass(factor(obj$value, levels=obj$attributes$levels$value)));
	}
}
