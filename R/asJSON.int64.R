setOldClass("int64")
setMethod("asJSON", "int64",
	function(x, ...) asJSON(as.double(as.character(x)), digits=0, ...)		
);

## int64 does not have direct as.double or as.numeric ????