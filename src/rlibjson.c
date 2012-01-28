#include <libjson/libjson.h>
#include <Rdefines.h>

SEXP processJSONNode(JSONNODE *node, int parentType, int simplify, SEXP nullValue, int simplifyWithNames, cetype_t);

typedef enum {NONE, ALL, STRICT_LOGICAL = 2, STRICT_NUMERIC = 4, STRICT_CHARACTER = 8, STRICT = 14} SimplifyStyle;

int setType(int cur, int newType);
SEXP makeVector(SEXP l, int len, int type, SEXP nullValue);

SEXP
R_fromJSON(SEXP r_str, SEXP simplify, SEXP nullValue, SEXP simplifyWithNames, SEXP encoding)
{
    const char * str = CHAR(STRING_ELT(r_str, 0));
    JSONNODE *node;
    SEXP ans;
    node = json_parse(str);
    ans = processJSONNode(node, json_type(node), INTEGER(simplify)[0], nullValue, LOGICAL(simplifyWithNames)[0],
 			  INTEGER(encoding)[0]);
    json_delete(node);
    return(ans);
}

SEXP 
processJSONNode(JSONNODE *n, int parentType, int simplify, SEXP nullValue, int simplifyWithNames, cetype_t charEncoding)
{
    
    if (n == NULL){
        PROBLEM "invalid JSON input"
	    ERROR;
    }
 
    JSONNODE *i;
    int len = 0, ctr = 0;
    int nprotect = 0;
    int numNulls = 0;
    len = json_size(n);
    char startType = parentType; // was 127
    
    int isNullHomogeneous = (TYPEOF(nullValue) == LGLSXP || TYPEOF(nullValue) == REALSXP || TYPEOF(nullValue) == STRSXP || TYPEOF(nullValue) == INTSXP);
    int numStrings = 0;
    int numLogicals = 0;
    int numNumbers = 0;

    SEXP ans, names = NULL;
    PROTECT(ans = NEW_LIST(len)); nprotect++;

    int homogeneous = 0;
    int elType = NILSXP;
    while (ctr < len){  // i != json_end(n)

	i = json_at(n, ctr);

        if (i == NULL){
            PROBLEM "Invalid JSON Node"
		ERROR;
        }

	json_char *node_name = json_name(i);
	
	char type = json_type(i);
	if(startType == 127)
	    startType = type;

	SEXP el;
	switch(type) {
   	   case JSON_NULL:
	       el = nullValue; /* R_NilValue; */
	       numNulls++;
	       if(isNullHomogeneous) {
		   homogeneous++;
		   elType = setType(elType, TYPEOF(nullValue));
	       } else
		   elType = TYPEOF(nullValue);
	       break;
   	   case JSON_ARRAY:
  	   case JSON_NODE:
	       el = processJSONNode(i, type, simplify, nullValue, simplifyWithNames, charEncoding);
	       if(Rf_length(el) > 1)
		   elType = VECSXP;
	       else
		   elType = setType(elType, TYPEOF(el));
	       break;
 	   case JSON_NUMBER:
	       el = ScalarReal(json_as_float(i));
	       homogeneous++;
	       elType = setType(elType, REALSXP);
	       numNumbers++;
	       break;
 	   case JSON_BOOL:
	       el = ScalarLogical(json_as_bool(i));
	       elType = setType(elType, LGLSXP);
	       numLogicals++;
	       break;
 	   case JSON_STRING:
	   {
//XXX Garbage collection
	       char *tmp = json_as_string(i);
                   // do we need to strdup here?
#if 0
	       el = ScalarString(mkChar(tmp));
#else
               el = ScalarString(mkCharCE(tmp, charEncoding));
#endif
	       elType = setType(elType, STRSXP);
	       json_free(tmp);
	       numStrings++;
	   }
	       break;
	default:
	    PROBLEM "shouldn't be here"
		WARN;
	    el = R_NilValue;
	    break;
	}
	SET_VECTOR_ELT(ans, ctr, el);

	if(parentType == JSON_NODE || (node_name && node_name[0])) {
	    if(names == NULL) {
	        PROTECT(names = NEW_CHARACTER(len)); nprotect++;
	    }
	    if(node_name && node_name[0])
		SET_STRING_ELT(names, ctr, mkChar(node_name));
	}
	json_free(node_name);
	ctr++;
    }

    /* If we have an empty object, we try to make it into a form equivalent to emptyNamedList
       if it is a {},  or as an AsIs object in R if an empty array. */
    if(len == 0 && (parentType == -1 || parentType == JSON_ARRAY || parentType == JSON_NODE)) {
        if(parentType == -1) 
            parentType = startType;

        if(parentType == JSON_NODE)
	   SET_NAMES(ans, NEW_CHARACTER(0));
        else  {
	   SET_CLASS(ans, ScalarString(mkChar("AsIs")));
	}

    } else if(simplifyWithNames || names == NULL || Rf_length(names) == 0) {
	int allSame = (numNumbers == len || numStrings == len || numLogicals == len) || 
	    ((TYPEOF(nullValue) == LGLSXP && LOGICAL(nullValue)[0] == NA_INTEGER) && 
	     ((numNumbers + numNulls) == len || (numStrings + numNulls) == len || (numLogicals + numNulls) == len));
        homogeneous = allSame ||  ( (numNumbers + numStrings + numLogicals + numNulls) == len);
        if(simplify == NONE) {
	} else if(allSame && 
                   (numNumbers == len && (simplify & STRICT_NUMERIC)) ||
	        	  ((numLogicals == len) && (simplify & STRICT_LOGICAL)) ||
		      ( (numStrings == len) && (simplify & STRICT_CHARACTER))) {
   	       ans = makeVector(ans, len, elType, nullValue);
	} else if((simplify == ALL && homogeneous) || (simplify == STRICT && allSame)) {
   	       ans = makeVector(ans, len, elType, nullValue);
	}
    }
      

    if(names)
	SET_NAMES(ans, names);
	
    UNPROTECT(nprotect);
    return(ans);
}

SEXP
makeVector(SEXP ans, int len, int type, SEXP nullValue)
{
    SEXP tmp;
    int ctr;

    if(type == REALSXP) {
	PROTECT(tmp = NEW_NUMERIC(len)); 
	for(ctr = 0; ctr < len; ctr++) {
	    SEXP el = VECTOR_ELT(ans, ctr);
	    REAL(tmp)[ctr] = TYPEOF(el) == LGLSXP && LOGICAL(el)[0] == NA_INTEGER ? NA_REAL : (TYPEOF(el) == REALSXP ? REAL(el)[0] : Rf_asReal(el));
	}
    } else if(type == LGLSXP) {
	PROTECT(tmp = NEW_LOGICAL(len)); 
	for(ctr = 0; ctr < len; ctr++) {
	    SEXP el = VECTOR_ELT(ans, ctr);
	    LOGICAL(tmp)[ctr] = TYPEOF(el) == LGLSXP ? LOGICAL(el)[0] : Rf_asInteger(el);
	}
    } else if(type == STRSXP) {
	PROTECT(tmp = NEW_CHARACTER(len)); 
	for(ctr = 0; ctr < len; ctr++) {
	    SEXP el = VECTOR_ELT(ans, ctr);
	    if(TYPEOF(el) == STRSXP)
		SET_STRING_ELT(tmp, ctr, STRING_ELT(el, 0));
	    else if(TYPEOF(el) == LGLSXP) {
		SET_STRING_ELT(tmp, ctr, LOGICAL(el)[0] == NA_INTEGER ? NA_STRING : mkChar(LOGICAL(el)[0] ? "TRUE" : "FALSE"));
	    } else if(TYPEOF(el) == REALSXP) {
		char buf[70];
		sprintf(buf, "%lf", REAL(el)[0]);
		SET_STRING_ELT(tmp, ctr, mkChar(buf));
	    }
	}
    } else
	return(ans);

    UNPROTECT(1);
    return(tmp);
}

int setType(int cur, int newType)
{
    if(cur == newType)
	return(cur);

    if(newType == VECSXP || cur == VECSXP)
	return(VECSXP);

    switch(cur) {
    case INTSXP:
	switch(newType) {
	case LGLSXP:
	    return(INTSXP);
	    break;
	case REALSXP:
	    return(REALSXP);
	    break;
	case STRSXP:
	    return(STRSXP);
	    break;
	}
	break;
    case LGLSXP:
	switch(newType) {
	case INTSXP:
	    return(INTSXP);
	    break;
	case REALSXP:
	    return(REALSXP);
	    break;
	case STRSXP:
	    return(STRSXP);
	    break;
	}
	break;
    case REALSXP:
	switch(newType) {
	case INTSXP:
	    return(REALSXP);
	    break;
	case LGLSXP:
	    return(REALSXP);
	    break;
	case STRSXP:
	    return(STRSXP);
	    break;
	}
	break;
    case STRSXP:
	return(STRSXP);
	break;
    }

    return(newType);
}



SEXP
R_libjson_version()
{
    char buf[20];
    sprintf(buf, "%d.%d-%d", (int) __LIBJSON_MAJOR__,
    	                     (int) __LIBJSON_MINOR__,
	                     (int) __LIBJSON_PATCH__);

    return(ScalarString(mkChar(buf)));
}


SEXP
R_isValidJSON(SEXP input)
{
    const char *txt;
    int status = 0;
    txt = CHAR(STRING_ELT(input, 0));
    status = json_is_valid(txt);
    return(ScalarLogical(status));
}




/******************/

#if 0

SEXP
R_json_new_stream(SEXP fun, SEXP pullFun)
{
    JSONSTREAM *stream;
    stream = json_new_stream();
}

SEXP
R_json_stream_push(SEXP r_stream, SEXP r_txt)
{
    JSONSTREAM *stream;
    stream = R_getStreamRef(r_stream);

    json_stream_push(stream, CHAR(STRING_ELT(r_txt, 0)));
    return(ScalarLogical(1));
}
#endif

SEXP expr;

SEXP
R_json_node_type(SEXP r_ref)
{
    JSONNODE *node = (JSONNODE *) R_ExternalPtrAddr(r_ref);
    return(ScalarInteger( (int) json_type(node)));
}

void
R_stream_callback(JSONNODE *node) //, void *data)
{
//    SEXP expr = (SEXP) data;
    SEXP ref;
    ref = CAR(CDR(expr));
    R_SetExternalPtrAddr(ref, node);
    Rf_eval(expr, R_GlobalEnv);
}


SEXP 
makeNodeRef(JSONNODE *node)
{
    SEXP ans;
    PROTECT(ans = R_MakeExternalPtr(node, Rf_install("JSONNODE"), R_NilValue));
    SET_CLASS(ans, ScalarString(mkChar("JSONNODE")));
    UNPROTECT(1);
    return(ans);

}



SEXP
R_json_stream_parse(SEXP str, SEXP fun)
{
    JSONSTREAM *stream;
    SEXP nodeRef;

    PROTECT(expr = allocVector(LANGSXP, 2));
    SETCAR(expr, fun);
    nodeRef = makeNodeRef(NULL);
    SETCAR(CDR(expr), nodeRef);
//    stream = json_new_stream(R_stream_callback, NULL, expr);
    stream = json_new_stream(R_stream_callback);
    json_stream_push(stream, CHAR(STRING_ELT(str, 0)));
    UNPROTECT(1);
    return(R_NilValue);
}

