pack <- function(obj, ...) {
  
  #encode by storage mode
  encoding.mode <- typeof(obj);
  
  if(encoding.mode == "pairlist"){
    obj <- as.vector(obj, mode="list")
  }  
  
  if(encoding.mode == "closure"){
    obj <- as.list(obj)
  }
  
  #encode recursively
  list(
    type = as.scalar(encoding.mode), #scalar prevents boxing during asJSON
    attributes = givename(lapply(attributes(obj), pack, ...)),
    value = switch(encoding.mode,
       "NULL" = obj,
       "environment" = NULL,
       "externalptr" = NULL,
       "S4" = pack(attributes(getClass(class(obj)))$slots, ...), #the value is the class defintion. The slots are in the attributes.
       "raw" = base64_encode(unclass(obj)),
       "logical" = as.vector(unclass(obj), mode = "logical"),
       "integer" = as.vector(unclass(obj), mode = "integer"),
       "numeric" = as.vector(unclass(obj), mode = "numeric"),
       "double" = as.vector(unclass(obj), mode = "double"),
       "character" = as.vector(unclass(obj), mode = "character"),
       "complex" = as.vector(unclass(obj), mode = "complex"),
       "list" = unname(lapply(obj, pack, ...)),
       "pairlist" = unname(lapply(obj, pack, ...)),             
       "closure" = unname(lapply(obj, pack, ...)),
       "builtin" = deparse(unclass(obj)),
       "special" = deparse(unclass(obj)),
       "language" = deparse(unclass(obj)),
       "name" = deparse(unclass(obj)),
       "symbol" = deparse(unclass(obj)),
       "expression" = deparse(obj[[1]]),
       warning("No encoding has been defined for objects with storage mode ",encoding.mode, " and will be skipped.")	
    )
  );	
}

unpack <- function(obj){
  
  encoding.mode <- obj$type;

  newdata <- c(list(
    ".Data" = switch(encoding.mode,
       "NULL" = NULL,
       "environment" = emptyenv(), #Don't serialize environments for now
       "externalptr" = NULL, #see below fixNativeSymbol
       "S4" = stop("S4 unpacking not yet implemented"),
       "raw" = base64_decode(unlist(obj$value)),
       "logical" = as.logical(null2na(obj$value)),
       "integer" = as.integer(null2na(obj$value)),
       "numeric" = as.numeric(null2na(obj$value)),
       "double" = as.double(null2na(obj$value)),
       "character" = as.character(null2na(obj$value)),
       "complex" = buildcomplex(obj$value),			
       "list" = lapply(obj$value, unpack),
       "pairlist" = lapply(obj$value, unpack),
       "symbol" = makesymbol(x=unlist(obj$value)),
       "name" = makesymbol(x=unlist(obj$value)),  
       "expression" = parse(text=obj$value),
       "language" = as.call(parse(text=unlist(obj$value)))[[1]], #must be a better way?
       "special" = try(eval(parse(text=obj$value), envir=baseenv())), #this might be unsafe
       "builtin" = try(eval(parse(text=obj$value), envir=baseenv())), #this might be unsafe
       "closure" = lapply(obj$value, unpack),                     
       stop("Switch falling through for encode.mode: ", encoding.mode)
    )
  ), lapply(obj$attributes, unpack));
  
  #this is for serializing functions arguments: as.list(lm)$data
  if(identical(newdata[[1]], substitute())){
    return(substitute());
  }
  
  #build the output object
  output <- do.call("structure", newdata, quote=TRUE);
  
  #functions are special
  if(encoding.mode == "closure"){
    myfn <- as.function(output);
    environment(myfn) <- globalenv();
    return(myfn);   
  }
  
  #functions are special
  if(encoding.mode == "pairlist"){
    return(as.pairlist(output));  
  }
  
  #try to fix native symbols
  if(is(output, "NativeSymbolInfo")){
    try(output <- fixNativeSymbol(output));
  }
  
  #return
  return(output);
}
