pack <- function(obj, ...) {
  
  #encode by storage mode
  encoding.mode <- storage.mode(obj);
  
  if(encoding.mode == "function"){
    obj <- as.list(obj)
  }
  
  #encode recursively
  list(
    mode = as.scalar(encoding.mode), #scalar prevents boxing during asJSON
    attributes = givename(lapply(attributes(obj), pack, ...)),
    value = switch(encoding.mode,
       "NULL" = obj,
       "environment" = NULL,
       "S4" = pack(attributes(getClass(class(obj)))$slots, ...), #the value is the class defintion. The slots are in the attributes.
       "raw" = base64_encode(unclass(obj)),
       "logical" = as.vector(unclass(obj), mode = "logical"),
       "integer" = as.vector(unclass(obj), mode = "integer"),
       "numeric" = as.vector(unclass(obj), mode = "numeric"),
       "double" = as.vector(unclass(obj), mode = "double"),
       "character" = as.vector(unclass(obj), mode = "character"),
       "list" = unname(lapply(obj, pack, ...)),
       "function" = unname(lapply(obj, pack, ...)),
       "language" = deparse(unclass(obj)),
       "name" = deparse(unclass(obj)),
       "symbol" = deparse(unclass(obj)),
       "complex" = obj,
       "expression" = deparse(obj[[1]]),
       warning("No encoding has been defined for objects with storage mode ",encoding.mode, " and will be skipped.")	
    )
  );	
}

unpack <- function(obj){
  
  encoding.mode <- obj$mode;

  newdata <- c(list(
    ".Data" = switch(encoding.mode,
       "NULL" = NULL,
       "environment" = emptyenv(), #Don't serialize environments for now
       "S4" = stop("S4 unpacking not yet implemented"),
       "raw" = base64_decode(unlist(obj$value)),
       "logical" = as.logical(null2na(obj$value)),
       "integer" = as.integer(null2na(obj$value)),
       "numeric" = as.numeric(null2na(obj$value)),
       "double" = as.double(null2na(obj$value)),
       "character" = as.character(null2na(obj$value)),
       "complex" = buildcomplex(obj$value),			
       "list" = lapply(obj$value, unpack),
       "symbol" = makesymbol(x=unlist(obj$value)),
       "name" = makesymbol(x=unlist(obj$value)),  
       "expression" = parse(text=obj$value),
       "language" = as.call(parse(text=unlist(obj$value)))[[1]], #must be a better way?
       "function" = lapply(obj$value, unpack),                     
       stop("Switch falling through for encode.mode: ", encoding.mode)
    )
  ), lapply(obj$attributes, unpack));
  
  #this is for serializing functions arguments: as.list(lm)$data
  if(identical(newdata[[1]], substitute())){
    return(substitute());
  }
  output <- do.call("structure", newdata, quote=TRUE);
  if(encoding.mode == "function"){
    return(as.function(output));
  }
  return(output);
}
