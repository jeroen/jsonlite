setOldClass("integer")
setMethod("asJSON", "integer",
	function(x, ...) asJSON(as.double(x), digits=0, ...)		
);

