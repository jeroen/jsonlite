#packaging and depacking objects into lists.
setGeneric("packageObject", function(obj, ...){  
	standardGeneric("packageObject");
});

setMethod("packageObject", "Date", function(obj, Date=c("ISO8601", "epoch"), ...) {
	#Validate:
	Date <- match.arg(Date);
	
	#packaged object
	list(
		encode.mode = as.scalar("Date"),
		attributes = givename(lapply(attributes(obj), packageObject, Date=Date, ...)),
		value = obj
	);
});

setMethod("packageObject", "POSIXt", function(obj, POSIXt = c("ISO8601", "epoch", "mongo"), ...) {
	#used for POSIXlt
	options("digits.secs" = 0);			
	
	#Validate:
	POSIXt <- match.arg(POSIXt);
	
	#Force to POSIXct
	obj <- as.POSIXct(obj);
	
	#packaged object
	list(
		encode.mode = as.scalar("POSIXt"),
		attributes = givename(lapply(attributes(obj), packageObject, POSIXt=POSIXt, ...)),
		value = obj
	);	
});

setMethod("packageObject", "data.frame", function(obj, data.frame=c("records", "list"), ...) {
	#validate
	data.frame <- match.arg(data.frame);
	
	#encode data frame by columns:
	if(data.frame == "list"){
		nextmethod <- getMethod("packageObject", "ANY");
		return(nextmethod(obj, ...));
	};
			
	#packaged object
	list(
		encode.mode = as.scalar("data.frame"),
		attributes = givename(list()),
		value = list(
			records = obj,
			columns = packageObject(as.list(obj[vector(), ,drop=FALSE]))
		)
	);	
});

setMethod("packageObject", "factor", function(obj, ...) {
	#packaged object
	list(
		encode.mode = as.scalar("factor"),
		attributes = givename(lapply(attributes(obj), packageObject, ...)),
		value = obj
	);

});

setMethod("packageObject", "ANY", function(obj, ...) {
	
	#encode by storage mode
	encoding.mode <- storage.mode(obj);
	
	#encode recursively
	return(
		list(
			encode.mode = as.scalar(encoding.mode), #scalar prevents boxing during asJSON
			attributes = givename(lapply(attributes(obj), packageObject, ...)),
			value = switch(encoding.mode,
				"NULL" = obj,
				"environment" = NULL,
				"S4" = packageObject(attributes(getClass(class(obj)))$slots, ...), #the value is the class defintion. The slots are in the attributes.
				"raw" = base64_encode(unclass(obj)),
				"logical" = as.vector(unclass(obj), mode = "logical"),
				"integer" = as.vector(unclass(obj), mode = "integer"),
				"numeric" = as.vector(unclass(obj), mode = "numeric"),
				"double" = as.vector(unclass(obj), mode = "double"),
				"character" = as.vector(unclass(obj), mode = "character"),
				"list" = unname(lapply(obj, packageObject, ...)),
				"language" = deparse(unclass(obj)),
				"function" = deparse(unclass(obj)),
				"name" = deparse(unclass(obj)),
				"symbol" = deparse(unclass(obj)),
				"complex" = obj,
				"expression" = as.character(unclass(obj)),					
				warning("No encoding has been defined for objects with encoding mode ",encoding.mode, " and will be skipped.")	
			)			
		)
	);	
});

depackageObject <- function(obj, safe){
	
	encodes.data <- c("Date", "POSIXt", "factor", "data.frame", "NULL", "environment", "raw",
			"logical", "integer", "numeric", "double", "character", "complex", "list");
	encodes.language <- c("symbol", "name", "expression", "language", "function");
	
	if(obj$encode.mode %in% encodes.data){
		mydata <- switch(obj$encode.mode,
				"Date" = parseDate(null2na(obj$value)),
				"POSIXt" = parseTimestamp(null2na(obj$value)),
				"factor" = buildfactor(obj),
				"data.frame" = as.data.frame(depackageObject(builddf(obj$value$records, obj$value$columns), safe=safe)),
				"NULL" = NULL,
				"environment" = NULL,
				"S4" = stop("S4 depackaging not yet implemented"),
				"raw" = base64_decode(unlist(obj$value)),
				"logical" = as.logical(null2na(obj$value)),
				"integer" = as.integer(null2na(obj$value)),
				"numeric" = as.numeric(null2na(obj$value)),
				"double" = as.double(null2na(obj$value)),
				"character" = as.character(null2na(obj$value)),
				"complex" = buildcomplex(obj$value),			
				"list" = lapply(obj$value, depackageObject, safe=safe),
				stop("Switch falling through for encode.mode: ", obj$encode.mode)
		);
	} else if(obj$encode.mode %in% encodes.language){
		if(safe){
			mydata <- switch(obj$encode.mode,
					"symbol" = parse(text=unlist(obj$value)), #as.symbol will be evaluated by structure()
					"name" = parse(text=unlist(obj$value)),	#as.name will be evaluated by structure()
					"expression" = parse(text=obj$value),
					"language" = parse(text=unlist(obj$value)), #results in an expression
					"function" = parse(text=unlist(obj$value)), #results in an expression			
					stop("Switch falling through for encode.mode: ", obj$encode.mode)			
			);	
		} else {
			mydata <- switch(obj$encode.mode,
					"symbol" = parse(text=unlist(obj$value)),
					"name" = parse(text=unlist(obj$value)),	
					"expression" = parse(text=obj$value),
					"language" = parse(text=unlist(obj$value)), #results in an expression
					"function" = eval(parse(text=unlist(obj$value))), #results in an evaluation!!	
					stop("Switch falling through for encode.mode: ", obj$encode.mode)	
			);
		}
	}
	else {
		stop("Unknown encode.mode: ", obj$encode.mode, "\n");
	}
	
	attrib <- lapply(obj$attributes, depackageObject, safe=safe);
	newdata <- list(.Data=mydata);
	do.call("structure", c(newdata, attrib));
}
